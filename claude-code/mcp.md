# Claude Code MCP 服务器集成

> 来源：Anthropic 官方文档，Model Context Protocol 规范

## 什么是 MCP？

MCP（Model Context Protocol）是一个开放协议，让 AI 应用
连接到外部数据源、工具和服务。

```
Claude Code + MCP = Claude 能访问：
  - 数据库
  - API 服务
  - 文件系统
  - 浏览器
  - 任何 MCP 服务器
```

## 安装 MCP 服务器

### 方法 1：使用 /mcp 命令

```bash
# 在 Claude Code 会话中
/mcp add <name> --url <url>      # HTTP 服务器
/mcp add <name> --command <cmd>  # 本地命令
```

### 方法 2：在配置中添加

```json
// .claude/settings.json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/path/to/dir"]
    },
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "your-token"
      }
    }
  }
}
```

## 常用 MCP 服务器

### 文件系统
```bash
npx @modelcontextprotocol/server-filesystem /path/to/dir
```

### GitHub
```bash
npx @modelcontextprotocol/server-github
```

### 浏览器（Playwright）
```bash
npx @playwright/mcp
```

### 数据库
```bash
npx @modelcontextprotocol/server-sqlite db.sqlite
npx @modelcontextprotocol/server-postgres postgresql://...
```

### Sentry
```bash
npx @modelcontextprotocol/server-sentry
```

> 来源：Anthropic 官方文档，GitHub MCP Registry


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

4. 检查 GitHub MCP Registry
   https://github.com/modelcontextprotocol/servers
```

> 来源：Software Mansion Agentic Engineering Guide


══════════════════════════════════════════════
  管理 MCP 服务器
══════════════════════════════════════════════

```bash
# 在 Claude Code 会话中
/mcp                    # 查看已安装的服务器
/mcp add <name>         # 添加服务器
/mcp remove <name>      # 移除服务器
/reload-mcp             # 重新加载所有 MCP 服务器
```

> 来源：Anthropic 官方文档


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Anthropic 官方文档 — MCP
    https://docs.anthropic.com/en/docs/claude-code/mcp

[2] Model Context Protocol 官方规范
    https://modelcontextprotocol.io

[3] GitHub MCP Servers 仓库
    https://github.com/modelcontextprotocol/servers

[4] Software Mansion, "Agentic Engineering Guide — MCP"
    https://agentic-engineering.swmansion.com/becoming-productive/harness-engineering/
