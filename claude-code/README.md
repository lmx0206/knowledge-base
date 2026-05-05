# Claude Code 完整使用指南

> 创建时间：2026年5月
> 官方文档：https://docs.anthropic.com/en/docs/claude-code
> 适用平台：macOS / Linux / Windows (WSL)

## 什么是 Claude Code？

Claude Code 是 Anthropic 推出的终端 AI 编码 Agent。
它可以直接访问你的整个代码库，读文件、写代码、运行命令、执行多步任务。

```
不是 "粘贴代码到聊天窗口"
而是 "一个在你终端里工作的高级工程师"
```

## 目录

```
claude-code/
├── README.md              ← 你在这里（总览 + 目录）
├── setup.md               安装与配置
├── claude-md.md           CLAUDE.md 配置文件详解
├── skills.md              技能系统（Skills）
├── mcp.md                 MCP 服务器集成
├── hooks.md               Hooks 自动化
├── save-tokens.md         节省 Token 策略
└── tips-and-tricks.md     技巧与最佳实践
```


══════════════════════════════════════════════
  快速开始
══════════════════════════════════════════════

```bash
# 安装
npm install -g @anthropic-ai/claude-code

# 进入项目目录
cd your-project

# 启动
claude

# 首次使用会要求输入 API Key
```

> 来源：Anthropic 官方文档


══════════════════════════════════════════════
  核心概念
══════════════════════════════════════════════

### 1. CLAUDE.md — 项目配置文件

在项目根目录放置 CLAUDE.md，告诉 Claude 你的项目背景。
每次会话自动加载。

详见：claude-md.md

### 2. Skills — 技能系统

可复用的工作流程文档，让 Claude 学会特定任务的标准做法。

详见：skills.md

### 3. MCP — 模型上下文协议

连接外部工具和服务（数据库、API、文件系统等）。

详见：mcp.md

### 4. Hooks — 自动化钩子

在特定操作前后自动执行命令（如 lint、测试）。

详见：hooks.md


══════════════════════════════════════════════
  常用命令
══════════════════════════════════════════════

### 会话内斜杠命令

```bash
# 会话控制
/new                # 新会话
/clear              # 清屏 + 新会话
/compact            # 压缩上下文（节省 token）
/retry              # 重试上一条消息
/undo               # 撤销上一次交互

# 配置
/model              # 查看/切换模型
/config             # 查看配置

# 工具
/init               # 生成 CLAUDE.md
/mcp                # 管理 MCP 服务器
/hooks              # 管理 Hooks

# 信息
/cost               # 查看 token 使用量
/help               # 帮助
```

> 来源：Anthropic 官方文档


══════════════════════════════════════════════
  与其他工具的关系
══════════════════════════════════════════════

```
┌──────────────┬──────────────┬──────────────┐
│ Claude Code  │ Codex        │ Gemini CLI   │
├──────────────┼──────────────┼──────────────┤
│ Claude 模型  │ GPT 模型     │ Gemini 模型  │
│ CLAUDE.md    │ AGENTS.md    │ GEMINI.md    │
│ Skills       │ Skills       │ Extensions   │
│ Hooks        │ Hooks        │ 有限支持     │
│ MCP          │ MCP          │ MCP          │
│ 子代理       │ 子代理       │ 子代理       │
└──────────────┴──────────────┴──────────────┘

Superpowers 可以在所有三个工具上使用！
```


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Anthropic 官方文档 — Claude Code
    https://docs.anthropic.com/en/docs/claude-code

[2] Anthropic 官方文档 — Claude Code Best Practices
    https://www.anthropic.com/engineering/claude-code-best-practices

[3] Claude Code GitHub 仓库
    https://github.com/anthropics/claude-code

[4] Anthropic 官方文档 — Agent Skills
    https://platform.claude.com/docs/en/agents-and-tools/agent-skills

[5] Builder.io, "50 Claude Code Tips and Best Practices"
    https://www.builder.io/blog/claude-code-tips-best-practices
