# 实用工具与配置文件指南

> 本文件介绍上下文工程和驾驭工程中常用的配置文件和工具

## 核心配置文件

### 1. AGENTS.md — 项目级规则文件

放在项目根目录，AI Agent 每次对话自动加载。

```markdown
# AGENTS.md 示例（Android 项目）

## 项目概述
这是一个基于 Jetpack Compose 的 Android 应用。

## 技术栈
- 语言：Kotlin
- UI：Jetpack Compose
- 架构：MVVM + Clean Architecture
- 依赖注入：Hilt
- 网络：Retrofit + OkHttp
- 数据库：Room

## 代码规范
- 使用 Kotlin 官方代码风格
- 函数命名：camelCase
- 类命名：PascalCase
- 常量：SCREAMING_SNAKE_CASE

## 目录结构
app/
├── src/main/
│   ├── java/com/example/app/
│   │   ├── data/          # 数据层
│   │   ├── domain/        # 领域层
│   │   ├── presentation/  # 表现层
│   │   └── di/            # 依赖注入
│   └── res/               # 资源文件

## 常用命令
- 构建：./gradlew assembleDebug
- 测试：./gradlew test
- lint：./gradlew lint

## 已知问题
- Room 数据库迁移需要手动处理
- Compose 版本与 Kotlin 版本有兼容要求
```

### 2. CLAUDE.md — Claude Code 专用

与 AGENTS.md 类似，但是 Claude Code 特定的格式：

```markdown
# CLAUDE.md 示例

## 规则
- 始终使用 Kotlin，不要用 Java
- 修改代码后必须运行测试
- commit message 用英文，格式：type: description

## 工作流程
1. 先理解需求
2. 写测试（TDD）
3. 实现代码
4. 运行测试确认通过
5. 提交代码
```

### 3. .cursorrules — Cursor 专用

```markdown
# .cursorrules 示例

你是一个 Android 开发专家。
- 优先使用 Kotlin Coroutines 处理异步
- 使用 StateFlow 而非 LiveData
- 遵循 SOLID 原则
```

### 4. MEMORY.md / USER.md — 记忆文件

```markdown
# MEMORY.md 示例

## 环境
- macOS，Homebrew 包管理
- Android Studio 2024.x
- JDK 17

## 常用工具
- Git + GitHub
- Gradle 8.x
- AGP 8.x

## 经验教训
- Compose 编译慢时检查 Kotlin 版本兼容性
- Hilt 在多模块项目中需要额外配置
```

```markdown
# USER.md 示例

## 用户信息
- 名字：mason
- 角色：移动端开发者
- 偏好语言：中文

## 工作习惯
- 喜欢先看方案再动手
- 偏好 TDD 开发
- 使用 VS Code + Android Studio
```

## 各工具的配置文件对照

| 工具 | 配置文件 | 位置 |
|------|---------|------|
| Hermes Agent | AGENTS.md + Skills | 项目根目录 + ~/.hermes/skills/ |
| Claude Code | CLAUDE.md | 项目根目录 + ~/.claude/ |
| Cursor | .cursorrules | 项目根目录 |
| GitHub Copilot | .github/copilot-instructions.md | 项目根目录 |
| Codex | AGENTS.md | 项目根目录 |
| Windsurf | .windsurfrules | 项目根目录 |

## 最佳实践

### 写好 AGENTS.md 的 10 条建议

```
1. 保持简短 — Agent 的上下文窗口有限
2. 放具体信息 — 文件路径、命令、版本号
3. 写代码规范 — 不要让 Agent "猜"你的风格
4. 列常用命令 — build、test、lint、deploy
5. 写已知问题 — 避免 Agent 踩同样的坑
6. 写架构约束 — 模块边界、依赖方向
7. 用具体示例 — 比抽象规则更有效
8. 分层组织 — 根目录放通用规则，子目录放特定规则
9. 定期更新 — 项目演进时同步更新
10. 测试验证 — 写完后让 Agent 执行一次，看是否理解正确
```

### 规则文件的层次结构

```
~/.claude/CLAUDE.md          ← 全局规则（所有项目通用）
~/project/AGENTS.md           ← 项目级规则
~/project/src/AGENTS.md       ← 模块级规则（可选）
```

越靠近代码的规则优先级越高。

## 参考资源

- builder.io: "Improve your AI code output with AGENTS.md"
- Cursor: "Best practices for coding with agents"
- YouTube: "How I Write My AGENTS.md Files - Best Practices"
- Anthropic: "Effective context engineering for AI agents"

## 参考来源

- [Builder.io - Improve Your AI Code Output with AGENTS.md](https://www.builder.io/blog/agents-md)
- [Cursor - Best Practices for Coding with Agents](https://docs.cursor.com/context/rules)
- [Anthropic - Effective Context Engineering for AI Agents](https://docs.anthropic.com/en/docs/build-with-claude/context-engineering)
- [GitHub Copilot Instructions](https://docs.github.com/en/copilot/customizing-copilot/adding-repository-custom-instructions-for-github-copilot)
- [Windsurf Rules](https://docs.windsurf.com/windsurf/memories-and-rules)
