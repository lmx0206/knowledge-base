# Codex CLI 完整使用指南

> 创建时间：2026年5月
> 官方文档：https://developers.openai.com/codex
> GitHub：https://github.com/openai/codex
> 适用平台：macOS / Linux / Windows (WSL2)

## 什么是 Codex CLI？

Codex CLI 是 OpenAI 推出的终端 AI 编码 Agent，使用 Rust 实现。
它可以在本地运行，直接访问你的代码库，读文件、写代码、运行命令、执行多步任务。

```
不是 "粘贴代码到聊天窗口"
而是 "一个在你终端里工作的高级工程师"
```

## 目录

```
codex/
├── README.md              ← 你在这里（总览 + 目录）
├── skills.md              技能系统（Skills + Superpowers）
├── mcp.md                 MCP 服务器集成
├── hooks.md               Hooks 与自动化
├── save-tokens.md         节省 Token 策略
└── tips-and-tricks.md     技巧与最佳实践
```


══════════════════════════════════════════════
  快速开始
══════════════════════════════════════════════

```bash
# 安装（三种方式）
npm install -g @openai/codex
# 或
brew install --cask codex
# 或从 GitHub Releases 下载对应平台的二进制文件

# 进入项目目录
cd your-project

# 启动
codex
```

### 认证方式

```
方式 1：ChatGPT 计划登录（推荐）
  - 支持 Plus、Pro、Business、Edu、Enterprise 计划
  - 启动 codex 后选择 "Sign in with ChatGPT"
  - 无需管理 API Key

方式 2：API Key
  - 从 https://platform.openai.com 获取
  - export OPENAI_API_KEY="your-key"
  - 需要额外设置
```

### 系统要求

```
操作系统：macOS 12+、Ubuntu 20.04+/Debian 10+、Windows 11 (WSL2)
Git：2.23+（推荐，用于 PR 辅助功能）
内存：4GB 最低，8GB 推荐
```

> 来源：OpenAI 官方文档


══════════════════════════════════════════════
  核心特性
══════════════════════════════════════════════

### 1. Rust 实现 — 快速、零依赖

Codex CLI 使用 Rust 重写，无需 Node.js 等运行时依赖。
安装包小，启动快，内存占用低。

### 2. 交互式 TUI（终端用户界面）

```bash
codex                    # 启动交互式 TUI
codex "explain this"     # 带初始提示启动
```

TUI 基于 Ratatui 构建，支持：

- 多轮对话
- 代码高亮
- 文件操作确认
- 键盘快捷键导航

### 3. 沙箱安全系统

Codex 内置沙箱，限制 Agent 可执行的操作：

```
┌─────────────────────────────────────────────────────┐
│  沙箱模式                                           │
│                                                     │
│  read-only（默认）                                   │
│    Agent 只能读取文件，不能写入或执行危险命令        │
│    最安全，适合代码审查和理解                         │
│                                                     │
│  workspace-write                                     │
│    Agent 可以在当前工作目录写入文件                   │
│    包含 ~/.codex/memories 的写入权限                 │
│    适合日常开发                                       │
│                                                     │
│  danger-full-access                                  │
│    Agent 拥有完全访问权限                             │
│    仅在容器等隔离环境中使用                           │
│    ⚠️ 危险                                            │
└─────────────────────────────────────────────────────┘
```

```bash
# 使用 --sandbox 标志选择模式
codex --sandbox read-only
codex --sandbox workspace-write
codex --sandbox danger-full-access

# 或在 config.toml 中持久化
# sandbox_mode = "workspace-write"
```

### 4. 非交互式执行（codex exec）

```bash
# 直接执行任务，无 TUI
codex exec "fix the bug in auth.py"

# 从 stdin 读取输入
echo "my output" | codex exec "Summarize this concisely"

# 临时会话（不保存 rollout 文件）
codex exec --ephemeral "quick task"
```

适用于 CI/CD 管道、脚本自动化。

### 5. MCP 支持（客户端 + 服务器）

Codex 既是 MCP 客户端，也是 MCP 服务器（实验性）。
详见：mcp.md

### 6. 通知系统

当 Agent 完成一轮工作时，可以配置桌面通知：

- macOS：通过 terminal-notifier
- WSL2：自动回退到 Windows 原生 Toast 通知

### 7. 沙箱测试命令

```bash
# 测试命令在沙箱中的行为
codex sandbox macos [--log-denials] [COMMAND]
codex sandbox linux [COMMAND]
codex sandbox windows [COMMAND]
```

> 来源：OpenAI 官方文档


══════════════════════════════════════════════
  配置文件
══════════════════════════════════════════════

### config.toml — 主配置文件

Codex 使用 TOML 格式（不是 JSON）：

```toml
# ~/.codex/config.toml

# 沙箱模式
sandbox_mode = "workspace-write"

# 通知配置
[notify]
command = "terminal-notifier"
args = ["-title", "Codex", "-message", "Turn completed"]

# MCP 服务器
[mcp_servers.fileserver]
command = "npx"
args = ["@modelcontextprotocol/server-filesystem", "/path/to/dir"]
```

### AGENTS.md — 项目规则文件

与 Claude Code 的 CLAUDE.md 类似，放在项目根目录：

```markdown
# AGENTS.md

## 技术栈
- Kotlin + Jetpack Compose
- MVVM + Clean Architecture

## 规则
- 使用 Kotlin，不要用 Java
- 使用 StateFlow 而非 LiveData
- 遵循 Material 3

## 常用命令
- 构建：./gradlew assembleDebug
- 测试：./gradlew test
```

> 来源：OpenAI 官方文档


══════════════════════════════════════════════
  与其他工具对比
══════════════════════════════════════════════

```
┌──────────────┬──────────────┬──────────────┬──────────────┐
│ 特性          │ Codex CLI    │ Claude Code  │ Gemini CLI   │
├──────────────┼──────────────┼──────────────┼──────────────┤
│ 实现语言      │ Rust         │ TypeScript   │ TypeScript   │
│ 配置格式      │ TOML         │ JSON         │ JSON         │
│ 项目文件      │ AGENTS.md    │ CLAUDE.md    │ GEMINI.md    │
│ 沙箱         │ ✅ 内置       │ ❌ 无        │ ✅ 内置       │
│ MCP 客户端    │ ✅           │ ✅           │ ✅           │
│ MCP 服务器    │ ✅ 实验性    │ ❌           │ ❌           │
│ Skills       │ ✅           │ ✅           │ ✅ Extensions│
│ Hooks        │ ✅ 通知型    │ ✅ 12 事件   │ ✅ 11 事件   │
│ 免费额度      │ ChatGPT 计划 │ 需 API Key   │ 60次/分 免费 │
│ 非交互模式    │ codex exec   │ --print      │ --headless   │
│ 认证方式      │ ChatGPT/API  │ API Key      │ Google OAuth │
└──────────────┴──────────────┴──────────────┴──────────────┘
```


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] OpenAI Codex 官方文档
    https://developers.openai.com/codex

[2] Codex CLI GitHub 仓库
    https://github.com/openai/codex

[3] Codex 配置文档
    https://developers.openai.com/codex/config-basic

[4] Codex 高级配置
    https://developers.openai.com/codex/config-advanced

[5] OpenAI Codex 安装文档
    https://github.com/openai/codex/blob/main/docs/install.md
