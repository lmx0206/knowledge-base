# AI Agent 实践指南：让 Claude Code / Codex / Hermes 理解你的项目

> 针对 mason 的场景：Flutter + Android 开发
> 更新时间：2026年5月
> 来源：OpenAI、Anthropic、Martin Fowler、社区实践

## 核心理念

```
Agent = Model + Harness
        模型    驾驭（你来设计的部分）

你无法改变模型的能力，但你可以设计环境让 Agent 更可靠。
同一个模型，从 20% 成功率 → 100%，靠的不是换模型，而是搭好 Harness。
```

真实数据：

- 一个 TypeScript 项目：裸仓库 20% 成功率 → 完整 Harness 100%
- 一个 FastAPI 项目：加 AGENTS.md 前 3 次全失败 → 加了后 3 次全成功
- 上下文效率提升约 60%


══════════════════════════════════════════════════════════════
  第一部分：Harness 的 5 个子系统
══════════════════════════════════════════════════════════════

每个有效的 Harness 都由 5 个部分组成：

```
┌─────────────────────────────────────────────────────┐
│  #   子系统         职责                  关键文件     │
│─────────────────────────────────────────────────────│
│  1   指令系统       告诉 Agent 做什么    AGENTS.md    │
│      Instructions   按什么顺序做         CLAUDE.md    │
│                                           docs/      │
│─────────────────────────────────────────────────────│
│  2   状态系统       跟踪已完成/进行中    progress.md  │
│      State          跨会话保持           feature.json │
│                                           git log    │
│─────────────────────────────────────────────────────│
│  3   验证系统       只有通过测试才算     tests        │
│      Verification   完成                 lint         │
│                                           type-check │
│─────────────────────────────────────────────────────│
│  4   范围控制       一次只做一件事       feature      │
│      Scope          不过度扩展           boundaries   │
│─────────────────────────────────────────────────────│
│  5   会话生命周期   开始初始化           init.sh      │
│      Lifecycle      结束清理             handoff.md   │
│                                           clean git  │
└─────────────────────────────────────────────────────┘
```

投资回报率排序（从高到低）：

```
1. 验证系统（测试 + lint）— ROI 最高，投入最低
2. 指令系统（AGENTS.md）— 立竿见影
3. 状态系统（progress.md）— 长任务必备
4. 范围控制（feature_list）— 防止 Agent 失控
5. 会话生命周期（init.sh）— 锦上添花
```


══════════════════════════════════════════════════════════════
  第二部分：配置文件详解
══════════════════════════════════════════════════════════════

## 2.1 AGENTS.md — Agent 的操作手册

### 通用结构（所有工具都读）

```markdown
# AGENTS.md

## 项目概述
[一句话描述项目]

## 技术栈
[列出核心技术]

## 开始工作前
1. 运行 ./init.sh 检查环境
2. 阅读 progress.md 了解上次进度
3. 阅读 feature_list.json 了解当前状态
4. 检查 git log --oneline -10 了解最近改动

## 规则（最多 15 条硬约束）
[最重要的规则，放在最前面]

## 目录结构
[关键目录说明]

## 常用命令
[build、test、lint 等]

## 已知问题
[Agent 容易踩的坑]
```

### 关键原则

```
1. 保持 50-200 行 — 太长会降低效果
2. 关键规则放顶部或底部 — 不要放中间（Lost in the Middle 效应）
3. 每条规则说明：为什么 + 什么时候用 + 什么时候删除
4. 不要写 Agent 能自己查到的信息（如 API 文档）
5. 不要写会频繁变化的信息
6. 定期审计 — 删除过时规则
```

### 反面教材（不要这样写）

```markdown
# 不好的 AGENTS.md 示例
这是一个 Flutter 项目。
# 命令参考
```bash
flutter pub get
flutter run
flutter test
```

# 结构

- lib/ 是代码目录
- test/ 是测试目录

→ 问题：没有架构约束、没有工作流程、没有验证步骤
   Agent 能自己发现这些信息，不需要你写

```

---

## 2.2 Flutter 项目完整模板

### CLAUDE.md（Claude Code 专用）

```markdown
# Flutter 项目 — Claude Code 配置

## 项目概述
[你的 App 名称] — 一个 [功能描述] 的 Flutter 应用。

## 技术栈
- Flutter 3.x + Dart 3.x
- 状态管理：Riverpod 2.x
- 路由：go_router
- 网络：dio + retrofit
- 本地存储：shared_preferences + drift (SQLite)
- 代码生成：freezed + json_serializable + build_runner
- 测试：flutter_test + mocktail + patrol

## 架构：Feature-First Clean Architecture

```

lib/
├── core/                  # 全局共享
│   ├── config/            # 环境配置
│   ├── di/                # 依赖注入
│   ├── error/             # 错误处理
│   ├── network/           # 网络层
│   ├── theme/             # 主题
│   └── utils/             # 工具类
├── features/              # 按功能模块组织
│   ├── auth/
│   │   ├── data/          # 数据层
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/        # 领域层
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/  # 表现层
│   │       ├── providers/
│   │       ├── screens/
│   │       └── widgets/
│   ├── home/
│   └── settings/
└── main.dart

```

## 代码规范
- 文件名：snake_case.dart
- 类名：PascalCase
- 变量/函数：camelCase
- 常量：SCREAMING_SNAKE_CASE
- 使用 const 构造函数（性能优化）
- 优先使用 final
- 使用 Dart 3 的模式匹配和记录类型

## 命令
- 安装依赖：flutter pub get
- 代码生成：dart run build_runner build --delete-conflicting-outputs
- 运行测试：flutter test
- 运行单个测试：flutter test test/features/auth/domain/usecases/login_test.dart
- 静态分析：dart analyze
- 格式化：dart format .
- 构建 APK：flutter build apk --release
- 构建 iOS：flutter build ios --release

## 工作流程规则
1. 每个 feature 一个分支
2. 先写测试，再写实现（TDD）
3. 修改代码后必须运行 dart analyze
4. 提交前运行 flutter test
5. commit message 格式：type(scope): description
   例：feat(auth): add Google Sign-In support

## 架构约束（硬规则）
- domain 层不能依赖任何外部包（只用 Dart 核心库）
- presentation 层不能直接访问 datasources
- Widget 不包含业务逻辑，只负责 UI
- 状态管理只用 Riverpod，不用 setState
- 网络请求只通过 Repository 抽象
- 所有 API 响应必须用 freezed 定义 Model

## 常见坑
- build_runner 生成文件后需要手动运行
- go_router 的 redirect 逻辑容易死循环
- Riverpod 的 autoDispose 要注意生命周期
- iOS 构建需要先 cd ios && pod install
```

### AGENTS.md（Codex / 通用专用）

```markdown
# AGENTS.md — Flutter 项目

## 开始工作前
1. 运行 `flutter pub get` 确保依赖安装
2. 运行 `dart run build_runner build --delete-conflicting-outputs` 确保代码生成
3. 运行 `flutter test` 确保测试通过
4. 阅读 progress.md 了解上次进度

## 硬约束（不可违反）
1. domain 层不依赖外部包
2. 所有 API 响应用 freezed 定义
3. 状态管理只用 Riverpod
4. 每个 feature 必须有测试
5. dart analyze 零警告才能提交

## 验证清单
完成任务前必须通过：
- [ ] flutter test 全部通过
- [ ] dart analyze 零警告
- [ ] dart format . 无变化
- [ ] 功能手动验证

## 代码风格
- 使用 const 构造函数
- 优先使用 final
- Widget 参数使用 Key? key
- 异步使用 async/await，不用 .then()
```

---

## 2.3 Android (Kotlin) 项目完整模板

### CLAUDE.md（Claude Code 专用）

```markdown
# Android 项目 — Claude Code 配置

## 项目概述
[App 名称] — 一个 [功能描述] 的 Android 应用。

## 技术栈
- 语言：Kotlin 2.x
- UI：Jetpack Compose
- 架构：MVVM + Clean Architecture
- 依赖注入：Hilt
- 网络：Retrofit + OkHttp + Moshi
- 数据库：Room
- 异步：Coroutines + Flow
- 测试：JUnit 5 + MockK + Turbine

## 模块结构
```

app/                    # 主模块
├── src/main/
│   ├── java/com/example/app/
│   │   ├── data/       # 数据层
│   │   │   ├── local/
│   │   │   ├── remote/
│   │   │   └── repository/
│   │   ├── domain/     # 领域层
│   │   │   ├── model/
│   │   │   ├── repository/
│   │   │   └── usecase/
│   │   ├── presentation/  # 表现层
│   │   │   ├── ui/
│   │   │   └── viewmodel/
│   │   └── di/         # Hilt 模块
│   └── res/
feature-auth/           # 认证功能模块（可选多模块）
feature-home/           # 首页功能模块
core/                   # 共享核心模块

```

## 命令
- 构建：./gradlew assembleDebug
- 测试：./gradlew test
- lint：./gradlew lint
- 连接设备测试：./gradlew connectedAndroidTest
- 清理：./gradlew clean

## 代码规范
- Kotlin 官方代码风格
- Compose 函数：PascalCase + 描述性命名
- 使用 StateFlow 而非 LiveData
- 使用 Material 3 组件
- 异步用 suspend + withContext(Dispatchers.IO)

## 架构约束
- data 层不能引用 presentation 层
- domain 层不能依赖 Android 框架
- ViewModel 不能直接访问 DataSource
- Compose 不包含业务逻辑
- 使用 Hilt 注入所有依赖

## 常见坑
- Room 迁移必须写 Migration
- Compose 版本与 Kotlin 版本有兼容矩阵
- Hilt 多模块需要额外 @InstallIn 配置
- Gradle 版本目录(libs.versions.toml)更新后需 sync
```

### AGENTS.md（Codex / 通用专用）

```markdown
# AGENTS.md — Android 项目

## 开始工作前
1. 运行 `./gradlew assembleDebug` 确保编译通过
2. 运行 `./gradlew test` 确保测试通过
3. 阅读 progress.md 了解上次进度

## 硬约束
1. Kotlin only，不要用 Java
2. 使用 StateFlow 而非 LiveData
3. 使用 Material 3
4. 每个 ViewModel 必须有单元测试
5. lint 零警告才能提交

## 验证清单
- [ ] ./gradlew test 全部通过
- [ ] ./gradlew lint 零警告
- [ ] ./gradlew assembleDebug 编译成功
- [ ] 功能在模拟器上验证
```


══════════════════════════════════════════════════════════════
  第三部分：Harness 工程实战
══════════════════════════════════════════════════════════════

## 3.1 最小可行 Harness（今天就能开始）

在你的项目根目录放这 4 个文件：

```
你的项目/
├── AGENTS.md           ← Agent 操作手册
├── CLAUDE.md           ← Claude Code 专用（可选，与 AGENTS.md 类似）
├── init.sh             ← 环境健康检查脚本
├── feature_list.json   ← 功能列表和状态
├── progress.md         ← 会话进度日志
├── DECISIONS.md        ← 架构决策记录
└── src/                ← 你的代码
```

### init.sh — Flutter 版本

```bash
#!/bin/bash
set -e
echo "=== 检查 Flutter 环境 ==="
flutter doctor -v
echo "=== 安装依赖 ==="
flutter pub get
echo "=== 代码生成 ==="
dart run build_runner build --delete-conflicting-outputs
echo "=== 运行测试 ==="
flutter test
echo "=== 静态分析 ==="
dart analyze
echo "=== 环境健康 ✓ ==="
```

### init.sh — Android 版本

```bash
#!/bin/bash
set -e
echo "=== 检查 Java 环境 ==="
java -version
echo "=== 构建项目 ==="
./gradlew assembleDebug
echo "=== 运行测试 ==="
./gradlew test
echo "=== lint 检查 ==="
./gradlew lint
echo "=== 环境健康 ✓ ==="
```

### feature_list.json

```json
{
  "features": [
    {
      "id": "F001",
      "name": "用户登录",
      "status": "done",
      "tests": "test/features/auth/login_test.dart"
    },
    {
      "id": "F002",
      "name": "首页列表",
      "status": "in-progress",
      "tests": "test/features/home/list_test.dart"
    },
    {
      "id": "F003",
      "name": "设置页面",
      "status": "not-started",
      "tests": null
    }
  ]
}
```

### progress.md

```markdown
# 进度日志

## Session 3 — 2026-05-05
- 完成：F001（用户登录）— 所有测试通过
- 进行中：F002（首页列表）— 数据层完成，UI 待实现
- 阻塞：无
- 下次应该：完成 F002 的 UI 部分，然后运行完整测试

## Session 2 — 2026-05-04
- 完成：项目初始化、依赖配置
- 发现：go_router 的 redirect 有坑，已记录到 DECISIONS.md
```

### DECISIONS.md

```markdown
# 架构决策记录 (ADR)

## ADR-001：选择 Riverpod 而非 Bloc
- 日期：2026-05-01
- 状态：已接受
- 原因：Riverpod 更简洁，编译时安全，社区活跃
- 备选方案：Bloc（更成熟但更啰嗦）

## ADR-002：使用 drift 而非 sqflite
- 日期：2026-05-03
- 状态：已接受
- 原因：drift 提供类型安全的 SQL 查询
- 备选方案：sqflite（更简单但无类型安全）
```

## 3.2 反馈循环设计

### 自动化验证（Hooks）

Claude Code 支持 Hooks — 在特定操作前后自动执行命令：

```json
// .claude/settings.json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "write|edit",
        "hooks": [
          {
            "type": "command",
            "command": "dart analyze --no-fatal-infos"
          }
        ]
      }
    ],
    "PreCommit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "flutter test && dart analyze"
          }
        ]
      }
    ]
  }
}
```

效果：每次 Agent 写完文件 → 自动运行静态分析 → 发现问题立即修复。

### Codex 的自动化

Codex 通过 AGENTS.md 中的指令实现类似效果：

```markdown
## 每次修改文件后
运行 `dart analyze` 检查是否有错误。如果有，立即修复。

## 每次完成任务前
运行 `flutter test` 确保所有测试通过。如果失败，修复后再提交。
```

## 3.3 跨会话状态管理

```
问题：Agent 没有跨会话记忆
解决：用文件持久化状态

Session 1 结束时：
  → 更新 progress.md（写了什么、做到哪、下次做什么）
  → 更新 feature_list.json（功能状态变化）
  → git commit（干净的检查点）

Session 2 开始时：
  → Agent 读 progress.md → 知道上次做到哪
  → Agent 读 feature_list.json → 知道什么已完成
  → Agent 读 git log → 知道最近改动
```

关键指标：新会话达到可工作状态的时间

- 好的 Harness：约 3 分钟
- 差的 Harness：15-20 分钟


══════════════════════════════════════════════════════════════
  第四部分：三个工具的对比和协作策略
══════════════════════════════════════════════════════════════

## 4.1 工具对比

```
┌──────────────┬──────────────┬──────────────┬──────────────┐
│              │ Claude Code  │ Codex        │ Hermes Agent │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ 配置文件     │ CLAUDE.md    │ AGENTS.md    │ AGENTS.md    │
│              │ .claude/     │              │ + Skills     │
│              │              │              │ + Memory     │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ 跨会话记忆   │ 无（靠文件） │ 无（靠文件） │ 有（内置）   │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ Hooks        │ 支持         │ 有限支持     │ 通过工具链   │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ 自动验证     │ Hooks        │ AGENTS.md    │ 工具调用     │
│              │              │ 指令         │              │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ 最佳用途     │ 复杂编码     │ 后台任务     │ 协调+记忆    │
│              │ 交互式开发   │ 批量处理     │ 定时任务     │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ 模型         │ Claude       │ GPT-5        │ mimo/任意    │
└──────────────┴──────────────┴──────────────┴──────────────┘
```

## 4.2 推荐工作流

```
日常开发流程：

1. Hermes Agent（协调者）
   - 管理项目记忆和进度
   - 定时检查 GitHub issues
   - 协调 Claude Code 和 Codex

2. Claude Code（主力编码）
   - 复杂功能实现
   - 代码审查和重构
   - 交互式调试

3. Codex（批量任务）
   - 后台运行测试
   - 生成 boilerplate 代码
   - 批量重构

具体操作：
┌─────────────────────────────────────────────────┐
│ 1. 对 Hermes 说："帮我做首页的用户列表功能"      │
│                                                 │
│ 2. Hermes：                                     │
│    - 读 progress.md 了解项目状态                 │
│    - 读 feature_list.json 确认下一个任务         │
│    - 生成详细的任务描述                          │
│                                                 │
│ 3. Hermes 委派给 Claude Code：                  │
│    hermes chat -q "实现用户列表功能，            │
│    参考 AGENTS.md 中的架构约束"                  │
│                                                 │
│ 4. Claude Code：                                │
│    - 读 CLAUDE.md 了解项目规范                   │
│    - 实现功能                                    │
│    - 运行测试验证                                │
│    - 提交代码                                    │
│                                                 │
│ 5. Hermes：                                     │
│    - 更新 progress.md                           │
│    - 更新 feature_list.json                     │
│    - 报告完成情况                                │
└─────────────────────────────────────────────────┘
```

## 4.3 共享上下文策略

让三个工具共享同一套上下文：

```
项目根目录/
├── AGENTS.md           ← Codex 和通用 Agent 读
├── CLAUDE.md           ← Claude Code 读
│                       （可以 symlink 到 AGENTS.md）
├── docs/
│   ├── architecture.md ← 详细架构文档
│   ├── api-patterns.md ← API 设计模式
│   └── testing.md      ← 测试规范
├── progress.md         ← 所有工具共享的进度
├── feature_list.json   ← 机器可读的功能状态
└── DECISIONS.md        ← 架构决策记录
```

关键：progress.md 和 feature_list.json 是所有工具的"真相来源"。


══════════════════════════════════════════════════════════════
  第五部分：12 条核心原则
══════════════════════════════════════════════════════════════

来源：OpenAI Codex 团队 + 社区实践总结

 1. 强模型 ≠ 可靠执行
    模型很强但可能犯低级错。先修 Harness，再考虑换模型。

 2. Harness 是 5 个子系统，不是一个更好的提示词
    指令、状态、验证、范围、生命周期缺一不可。

 3. 仓库是唯一真相来源
    Agent 看不到的信息等于不存在。所有必要信息放仓库里。

 4. 分拆指令，不要用一个巨大文件
    AGENTS.md 保持 50-200 行，详细内容放 docs/ 子目录。

 5. 跨会话持久化状态
    用 progress.md、feature_list.json、git commit 保持连续性。

 6. 每次会话前初始化
    运行 init.sh 检查环境，读 progress.md 了解上下文。

 7. 一次只做一件事（WIP=1）
    不要让 Agent 同时做 3 个功能，它会半途而废。

 8. 功能列表是 Harness 的原语
    用 feature_list.json 定义范围和完成标准。

 9. 不要让 Agent 提前宣布胜利
    必须通过测试才算完成，不是"代码写完了"就算。

10. 只有全流水线验证才算数
    测试 + lint + 类型检查 + 编译，全部通过才算完成。

11. 让 Agent 的运行时可观察
    日志、进度文件、git 历史，让人能随时检查。

12. 每次会话必须留下干净状态
    commit、更新进度、清理临时文件。


══════════════════════════════════════════════════════════════
  第六部分：今天就能做的 3 件事
══════════════════════════════════════════════════════════════

### 立即可做（5 分钟）

1. 在你的项目根目录创建 AGENTS.md
   → 使用上面的 Flutter 或 Android 模板
   → 填入你项目的实际信息

### 今天做（30 分钟）

2. 创建 init.sh + feature_list.json + progress.md
   → 复制上面的模板
   → 运行一次 init.sh 确认环境正常

### 本周做

3. 配置 Claude Code Hooks（自动验证）
   → 在 .claude/settings.json 中添加 PostToolUse hook
   → 让每次文件修改后自动运行 dart analyze


══════════════════════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════════════════════

- OpenAI: "Best practices – Codex"
  https://developers.openai.com/codex/learn/best-practices

- OpenAI: "Harness engineering: leveraging Codex in an agent-first world"
  https://openai.com/index/harness-engineering/

- Martin Fowler: "Harness engineering for coding agent users"
  https://martinfowler.com/articles/harness-engineering.html

- Sakasegawa: "Harness Engineering Best Practices for Claude Code / Codex Users"
  https://nyosegawa.com/en/posts/harness-engineering-best-practices-2026/

- Software Mansion: "Agentic Engineering Guide — Harness Engineering"
  https://agentic-engineering.swmansion.com/becoming-productive/harness-engineering/

- DEV Community: "Harness Engineering — Quick Actionable Guide"
  https://dev.to/truongpx396/harness-engineering-quick-actionable-guide-2b93

- My Android Solutions: "Claude Code for Android Development"
  https://www.myandroidsolutions.com/2026/02/28/claude-code-android-development-best-practices/

- Builder.io: "Improve your AI code output with AGENTS.md"
  https://www.builder.io/blog/agents-md

- Medium: "Building a Flutter App with Claude Code and Feature-First Clean Architecture"
  https://medium.com/@remy.baudet/building-a-flutter-app-with-claude-code-and-feature-first-clean-architecture-fa89fe5aa58b

- Flutter Blog: "Jaime's build context: Prompt engineering as infrastructure"
  https://blog.flutter.dev/jaimes-build-context-prompt-engineering-as-infrastructure-b335fd517101
