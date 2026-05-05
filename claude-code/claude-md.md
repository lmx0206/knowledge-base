# CLAUDE.md 配置文件详解

> 来源：Anthropic 官方文档 + 社区最佳实践

## 什么是 CLAUDE.md？

CLAUDE.md 是 Claude Code 的项目配置文件，类似于：
- Codex 的 AGENTS.md
- Cursor 的 .cursorrules
- GitHub Copilot 的 .github/copilot-instructions.md

每次会话开始时，Claude 会自动读取这个文件，了解你的项目背景。

## 文件位置

```
~/.claude/CLAUDE.md          ← 全局配置（所有项目通用）
~/project/CLAUDE.md          ← 项目级配置
~/project/src/CLAUDE.md      ← 模块级配置（可选）
```

越靠近代码的配置优先级越高。

## 自动生成

```bash
# 在 Claude Code 会话中运行
/init

# Claude 会扫描你的代码库，生成一个定制的 CLAUDE.md
```

> 来源：Anthropic 官方文档


══════════════════════════════════════════════
  应该写什么？
══════════════════════════════════════════════

### 应该包含

```
✓ Bash 命令（Claude 猜不到的）
✓ 代码风格规则（与默认不同的）
✓ 测试指令和首选测试框架
✓ 仓库礼仪（分支命名、PR 规范）
✓ 项目特定的架构决策
✓ 开发环境特殊要求（必要的环境变量）
✓ 常见陷阱或非显而易见的行为
```

### 不应该包含

```
✗ Claude 通过读代码就能发现的信息
✗ 标准语言规范（Claude 已经知道）
✗ 详细的 API 文档（链接到文档即可）
✗ 频繁变化的信息
✗ 逐文件的代码描述
✗ 显而易见的做法（如"写干净的代码"）
```

> 来源：Anthropic 官方文档，Software Mansion Agentic Engineering Guide


══════════════════════════════════════════════
  模板：Flutter 项目
══════════════════════════════════════════════

```markdown
# CLAUDE.md — Flutter 项目

## 项目概述
[App 名称] — [一句话描述]

## 技术栈
- Flutter 3.x + Dart 3.x
- 状态管理：Riverpod 2.x
- 路由：go_router
- 网络：dio
- 代码生成：freezed + json_serializable + build_runner

## 架构
Feature-First Clean Architecture（详见 docs/architecture.md）

## 命令
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
dart analyze
dart format .
```

## 硬约束
1. domain 层不依赖外部包
2. 状态管理只用 Riverpod
3. 每个 feature 必须有测试
4. dart analyze 零警告才能提交

## 常见坑
- build_runner 生成后需手动运行
- go_router redirect 容易死循环
- iOS 构建需先 cd ios && pod install
```


══════════════════════════════════════════════
  模板：Android 项目
══════════════════════════════════════════════

```markdown
# CLAUDE.md — Android 项目

## 项目概述
[App 名称] — [一句话描述]

## 技术栈
- Kotlin 2.x + Jetpack Compose
- MVVM + Clean Architecture
- Hilt (DI) + Retrofit (网络) + Room (数据库)
- Coroutines + Flow

## 命令
```bash
./gradlew assembleDebug
./gradlew test
./gradlew lint
```

## 硬约束
1. Kotlin only，不用 Java
2. 使用 StateFlow 而非 LiveData
3. 使用 Material 3
4. 每个 ViewModel 必须有单元测试
5. lint 零警告才能提交

## 架构约束
- data 层不能引用 presentation 层
- domain 层不能依赖 Android 框架
- ViewModel 不能直接访问 DataSource
```


══════════════════════════════════════════════
  最佳实践
══════════════════════════════════════════════

```
1. 保持简短（50-200 行）
   太长会占用上下文窗口，降低效果。

2. 关键规则放顶部
   LLM 对开头和结尾的内容记忆更好。

3. 用具体示例
   比抽象规则更有效。

4. 分层组织
   全局 → 项目 → 模块，越靠近代码优先级越高。

5. 定期审计
   删除过时规则，就像删除未使用的依赖一样。

6. 不要写 Claude 能自己查到的
   浪费上下文窗口。
```

> 来源：Builder.io "50 Claude Code Tips"，Anthropic 官方文档


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Anthropic 官方文档 — Claude Code
    https://docs.anthropic.com/en/docs/claude-code

[2] Builder.io, "Improve your AI code output with AGENTS.md"
    https://www.builder.io/blog/agents-md

[3] HumanLayer, "Writing a good CLAUDE.md"
    https://www.humanlayer.dev/blog/writing-a-good-claude-md

[4] Software Mansion, "Agentic Engineering Guide — Harness Engineering"
    https://agentic-engineering.swmansion.com/becoming-productive/harness-engineering/

[5] UX Planet, "CLAUDE.md Best Practices"
    https://uxplanet.org/claude-md-best-practices-1ef4f861ce7c
