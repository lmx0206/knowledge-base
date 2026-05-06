# Gemini CLI MCP 服务器集成

> 来源：Gemini CLI 官方文档、Model Context Protocol 规范
> 更新时间：2026年5月

## 什么是 MCP？

MCP（Model Context Protocol）是一个开放协议，让 AI 应用
连接到外部数据源、工具和服务。

```
Gemini CLI + MCP = Gemini 能访问：
  - 数据库
  - API 服务
  - 文件系统
  - 浏览器
  - 媒体生成（Imagen、Veo、Lyria）
  - 任何 MCP 服务器
```


══════════════════════════════════════════════
  配置 MCP 服务器
══════════════════════════════════════════════

### 在 settings.json 中配置

```json
// ~/.gemini/settings.json 或 .gemini/settings.json
{
  "mcpServers": {
    "fileserver": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/path/to/dir"]
    },
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "$GITHUB_TOKEN"
      }
    },
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp"]
    },
    "database": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-sqlite", "db.sqlite"]
    }
  }
}
```

### 支持的传输方式

```
Gemini CLI 支持三种 MCP 传输：
  1. Stdio — 子进程，通过 stdin/stdout 通信
  2. SSE — Server-Sent Events 端点
  3. Streamable HTTP — HTTP 流式通信
```

### 配置属性

```
必需（三选一）：
  command — Stdio 传输的可执行文件路径
  url — SSE 端点 URL
  httpUrl — HTTP 流式端点 URL

可选：
  args — 命令行参数
  headers — 自定义 HTTP 头
  env — 环境变量（支持 $VAR_NAME 语法）
  cwd — 工作目录
  timeout — 超时毫秒（默认 600000 = 10 分钟）
  trust — true 跳过确认（默认 false）
  includeTools — 只包含指定工具
  excludeTools — 排除指定工具
```

### 全局 MCP 设置

```json
{
  "mcp": {
    "allowed": ["my-trusted-server"],
    "excluded": ["experimental-server"]
  }
}
```


══════════════════════════════════════════════
  MCP 资源（Resources）
══════════════════════════════════════════════

Gemini CLI 支持 MCP 资源，可以直接在对话中引用：

```
# 引用 MCP 资源
@server://resource/path

# 例如引用 GitHub 仓库文件
@github://repo/owner/file.md
```

资源会出现在自动补全菜单中，与本地文件一起显示。


══════════════════════════════════════════════
  常用 MCP 服务器
══════════════════════════════════════════════

```
文件系统：npx @modelcontextprotocol/server-filesystem /path
GitHub：  npx @modelcontextprotocol/server-github
浏览器：  npx @playwright/mcp
SQLite：  npx @modelcontextprotocol/server-sqlite db.sqlite
Postgres：npx @modelcontextprotocol/server-postgres postgresql://...
Sentry：  npx @modelcontextprotocol/server-sentry

Google Cloud 特色：
媒体生成：Imagen、Veo、Lyria（通过 Vertex AI MCP）
```


══════════════════════════════════════════════
  管理 MCP 服务器
══════════════════════════════════════════════

```bash
# 在会话中
/mcp                # 查看已安装的服务器
/mcp add <name>     # 添加服务器
/mcp remove <name>  # 移除服务器
```


══════════════════════════════════════════════
  最佳实践
══════════════════════════════════════════════

```
1. 只安装需要的 MCP 服务器
   每个服务器都会注入工具定义到上下文，
   过多会降低 Agent 能力。

2. 使用 trust 设置提升效率
   信任的服务器设置 trust: true
   避免每次调用都要确认

3. 使用 includeTools/excludeTools
   只暴露需要的工具
   减少上下文占用

4. 环境变量安全
   用 $VAR_NAME 引用环境变量
   不要在 settings.json 中硬编码密钥

5. 注意安全
   MCP 服务器可以访问你的系统。
   只安装可信的服务器。
   项目级 hooks 有指纹验证。
```

> 来源：Gemini CLI 官方文档 — MCP Servers


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Gemini CLI MCP 文档
    https://geminicli.com/docs/tools/mcp-server

[2] Model Context Protocol 官方规范
    https://modelcontextprotocol.io

[3] GitHub MCP Servers 仓库
    https://github.com/modelcontextprotocol/servers

[4] Google Cloud Vertex AI Creative Studio MCP
    https://github.com/GoogleCloudPlatform/vertex-ai-creative-studio
