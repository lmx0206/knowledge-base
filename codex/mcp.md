# Codex MCP 服务器集成

> 来源：OpenAI 官方文档、Model Context Protocol 规范

## 什么是 MCP？

MCP（Model Context Protocol）是一个开放协议，让 AI 应用
连接到外部数据源、工具和服务。

```
Codex + MCP = Codex 能访问：
  - 数据库
  - API 服务
  - 文件系统
  - 浏览器
  - 任何 MCP 服务器
```

## Codex 的 MCP 特殊之处

Codex 既是 MCP **客户端**，也是 MCP **服务器**（实验性）。

```
┌─────────────────────────────────────────────┐
│  Codex MCP 双重角色                          │
│                                             │
│  客户端模式（Client）：                       │
│    Codex 连接到 MCP 服务器，使用其工具       │
│    配置在 config.toml 的 [mcp_servers] 段    │
│                                             │
│  服务器模式（Server）：实验性                 │
│    Codex 自身作为 MCP 服务器运行             │
│    其他 Agent 可以调用 Codex 作为工具        │
│    启动：codex mcp-server                    │
└─────────────────────────────────────────────┘
```


══════════════════════════════════════════════
  客户端模式：连接 MCP 服务器
══════════════════════════════════════════════

### 在 config.toml 中配置

```toml
# ~/.codex/config.toml

[mcp_servers.fileserver]
command = "npx"
args = ["@modelcontextprotocol/server-filesystem", "/path/to/dir"]

[mcp_servers.github]
command = "npx"
args = ["@modelcontextprotocol/server-github"]

[mcp_servers.playwright]
command = "npx"
args = ["@playwright/mcp"]

[mcp_servers.database]
command = "npx"
args = ["@modelcontextprotocol/server-sqlite", "db.sqlite"]
```

### 使用 codex mcp 命令管理

```bash
# 添加 MCP 服务器
codex mcp add <name> --command <cmd> --args <args>

# 列出已配置的服务器
codex mcp list

# 查看服务器详情
codex mcp get <name>

# 移除服务器
codex mcp remove <name>
```

### 常用 MCP 服务器

```
文件系统：npx @modelcontextprotocol/server-filesystem /path
GitHub：  npx @modelcontextprotocol/server-github
浏览器：  npx @playwright/mcp
SQLite：  npx @modelcontextprotocol/server-sqlite db.sqlite
Postgres：npx @modelcontextprotocol/server-postgres postgresql://...
Sentry：  npx @modelcontextprotocol/server-sentry
```

> 来源：GitHub MCP Registry https://github.com/modelcontextprotocol/servers


══════════════════════════════════════════════
  服务器模式：Codex 作为 MCP 服务器
══════════════════════════════════════════════

实验性功能。让其他 MCP 客户端（如 Claude Code、Cursor）
可以把 Codex 当作一个工具来使用。

```bash
# 直接启动 MCP 服务器
codex mcp-server

# 使用 MCP Inspector 测试
npx @modelcontextprotocol/inspector codex mcp-server
```

### 使用场景

```
- 在 Claude Code 中调用 Codex 的能力
- 构建多 Agent 系统，Codex 作为其中一个工具
- 自动化管道中复用 Codex 的代码理解能力
```


══════════════════════════════════════════════
  MCP 最佳实践
══════════════════════════════════════════════

```
1. 只安装需要的 MCP 服务器
   每个服务器都会注入工具定义到上下文，
   过多会降低 Agent 能力。

2. 优先使用 CLI 而非 MCP
   如果有 CLI 工具能做同样的事，优先用 CLI。
   Agent 对 Bash 命令的训练更充分。

3. 注意安全
   MCP 服务器可以访问你的系统。
   只安装可信的服务器。

4. 利用 Codex 的 MCP 服务器模式
   如果你同时使用多个 AI 工具，
   可以让 Codex 作为共享的代码理解引擎。
```

> 来源：Software Mansion Agentic Engineering Guide


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] OpenAI Codex 官方文档
    https://developers.openai.com/codex

[2] Codex CLI GitHub — MCP 文档
    https://github.com/openai/codex/blob/main/codex-rs/README.md

[3] Model Context Protocol 官方规范
    https://modelcontextprotocol.io

[4] GitHub MCP Servers 仓库
    https://github.com/modelcontextprotocol/servers
