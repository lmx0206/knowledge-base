# Hermes Agent 专属实践指南

> 针对 mason 的环境：mimo-v2.5-pro 模型 + macOS + Android/Flutter/iOS 开发

## 核心策略：用系统弥补模型能力不足

你的 mimo-v2.5-pro 可能不如 Claude 或 GPT-5 强，
但通过精心设计的上下文和驾驭系统，可以让它表现得远超预期。

```
公式：弱模型 + 好上下文 + 好驾驭 ≈ 强模型 + 糟糕配置
```

## 第一步：完善记忆系统（立即可做）

记忆是让模型"了解你"的最简单方式。

### 保存你的开发环境信息

```bash
# 在对话中告诉我，我会自动保存：
# - 你常用的 IDE（Android Studio、VS Code）
# - 你的项目技术栈
# - 你的代码风格偏好
# - 你常用的命令和工具
```

### 查看当前记忆

```bash
hermes memory status
```

## 第二步：配置辅助模型（推荐）

不同任务用不同模型，发挥各自优势：

```bash
# 编辑配置
hermes config edit
```

在 config.yaml 中设置：

```yaml
# 辅助模型配置示例
auxiliary:
  vision:
    provider: gemini          # 图像分析用 Gemini
    model: gemini-2.0-flash
  compression:
    provider: anthropic       # 上下文压缩用 Claude
    model: claude-sonnet-4
  session_search:
    provider: openrouter      # 搜索用 OpenRouter
    model: anthropic/claude-sonnet-4
```

这样：
- 日常对话 → mimo-v2.5-pro（免费/便宜）
- 图像理解 → Gemini（擅长视觉）
- 复杂压缩 → Claude（擅长总结）
- 关键推理 → OpenRouter（可选更强模型）

## 第三步：为你的项目写 AGENTS.md

### Android 项目模板

```markdown
# Android 项目 AGENTS.md

## 技术栈
- Kotlin + Jetpack Compose
- MVVM + Clean Architecture
- Hilt (DI) + Retrofit (网络) + Room (数据库)

## 构建命令
- 构建: ./gradlew assembleDebug
- 测试: ./gradlew test
- lint: ./gradlew lint
- 生成 APK: ./gradlew assembleRelease

## 代码规范
- 使用 Kotlin 官方风格
- Compose 函数用 PascalCase
- 使用 StateFlow 而非 LiveData
- 异步用 Coroutines

## 架构约束
- data 层不能引用 presentation 层
- domain 层不能依赖 Android 框架
- ViewModel 不能直接访问 Repository，必须通过 UseCase

## 常见坑
- Room 迁移必须写 Migration
- Compose 版本与 Kotlin 版本有兼容矩阵
- Hilt 多模块需要额外配置
```

### Flutter 项目模板

```markdown
# Flutter 项目 AGENTS.md

## 技术栈
- Flutter 3.x + Dart 3.x
- 状态管理：Riverpod
- 路由：go_router
- 网络：dio
- 本地存储：shared_preferences + sqflite

## 命令
- 运行: flutter run
- 测试: flutter test
- 构建 APK: flutter build apk
- 构建 iOS: flutter build ios
- 代码生成: dart run build_runner build

## 代码规范
- 使用 flutter_lints
- 文件名 snake_case
- 类名 PascalCase
- 使用 freezed 生成不可变类
```

## 第四步：积累技能库

每次完成复杂任务时，让我保存为技能：

```
你："帮我把这个保存为技能"
我：[创建技能文件到 ~/.hermes/skills/]
```

### 推荐积累的技能

```
android-项目初始化    — 新建 Android 项目的标准流程
flutter-项目初始化    — 新建 Flutter 项目的标准流程
compose-ui审查       — Jetpack Compose UI 代码审查清单
gradle-依赖更新       — 安全更新 Gradle 依赖的流程
app-发布流程         — 发布到 Play Store 的完整步骤
```

## 第五步：设置定时任务

```bash
# 每天早上检查 GitHub 通知
hermes cron create "0 9 * * *" -q "检查我的 GitHub 通知，总结需要处理的 issues 和 PRs"

# 每周生成开发周报
hermes cron create "0 18 * * 5" -q "总结本周的 Git 提交记录，生成开发周报"
```

## 第六步：利用工具弥补推理不足

当 mimo 遇到困难时，引导它用工具：

```
不确定？→ web_search 查一下
记不住？→ session_search 搜历史
需要计算？→ execute_code 跑 Python
需要验证？→ terminal 跑测试
需要看图？→ vision_analyze 分析截图
```

## 针对你的工作场景的具体建议

### Android Studio 开发

```
1. 在项目根目录放 AGENTS.md
2. 让 Hermes 帮你写单元测试
3. 让 Hermes 审查 Compose UI 代码
4. 用 terminal 工具跑 gradle 命令
```

### Codex 使用

```
1. Codex 本身就是 Harness 思维的实践者
2. 写好 AGENTS.md 让 Codex 更好理解项目
3. 用 Hermes 做 Codex 做不到的事（记忆、定时、多平台）
```

### Claude Code 使用

```
1. 写好 CLAUDE.md（与 AGENTS.md 类似）
2. 用 Hermes 的记忆系统弥补 Claude Code 无跨会话记忆的不足
3. 用 Hermes 的定时任务让 Claude Code 的工作自动化
```

## 总结：你的个人 AI 系统架构

```
┌─────────────────────────────────────────────┐
│                mason 的 AI 系统              │
│                                             │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐    │
│  │ Hermes  │  │  Codex  │  │ Claude  │    │
│  │ Agent   │  │         │  │ Code    │    │
│  └────┬────┘  └────┬────┘  └────┬────┘    │
│       │            │            │          │
│       └────────────┼────────────┘          │
│                    │                       │
│            ┌───────┴───────┐               │
│            │  共享上下文层   │               │
│            │               │               │
│            │ AGENTS.md     │               │
│            │ Memory        │               │
│            │ Skills        │               │
│            │ 工具链        │               │
│            └───────────────┘               │
└─────────────────────────────────────────────┘
```

## 下一步行动

告诉我你最想先做哪一步：
1. "帮我写 AGENTS.md" — 我帮你为项目生成规则文件
2. "帮我配置辅助模型" — 我引导你设置多模型策略
3. "帮我积累技能" — 告诉我你常做的任务，我帮你写成技能
4. "帮我设置定时任务" — 告诉我你想自动化什么
