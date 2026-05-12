# Claude HUD — Claude Code 实时监控仪表盘

> Claude HUD (Heads-Up Display) 是一个基于 Next.js 的实时监控仪表盘，用于监视 Claude Code 会话的工具使用、Token 消耗和费用。
> GitHub Stars: 143 | 许可证: MIT | 版本: 0.1.0

---

## 什么是 Claude HUD？

Claude HUD 是一个轻量级的 Web 仪表盘，通过 Claude Code SDK 获取数据，让开发者能**实时观察 Claude Code 的工作状态**。它解决了 Claude Code 运行时"黑盒"的问题 — 你可以在浏览器中看到 Claude 正在做什么、用了哪些工具、消耗了多少 Token、花了多少钱。

```
Claude Code (CLI)  →  Claude Code SDK  →  Claude HUD (Web UI)
   执行任务              数据源              实时可视化
```

## 核心功能

| 功能 | 说明 |
|------|------|
| 实时会话监控 | 实时显示 Claude Code 的工作进展 |
| 工具使用追踪 | 显示使用的工具（文件编辑、bash 命令、搜索等） |
| Token 用量分析 | 按消息监控 input/output token 消耗 |
| 费用追踪 | 基于 token 用量计算预估费用（支持 Sonnet/Haiku/Opus 三种模型定价） |
| 文件变更检测 | 追踪被读取、写入或修改的文件 |
| 会话时间线 | 完整的消息历史，含工具调用和结果 |
| 多会话支持 | 同时监控多个 Claude Code 会话 |
| 暗色主题 UI | 开发者友好的深色界面 |

## 技术栈

| 技术 | 版本 | 用途 |
|------|------|------|
| Next.js | 15 (App Router) | 全栈框架 |
| React | 19 | UI 框架 |
| TypeScript | — | 类型安全 |
| Tailwind CSS | v4 | 样式 |
| Recharts | — | 图表库 |
| @anthropic-ai/claude-code | SDK v0.2.0 | 数据源 |

## 安装与使用

```bash
# 克隆仓库
git clone https://github.com/jarrodwatts/claude-hud.git
cd claude-hud

# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

启动后在浏览器打开 `http://localhost:3000`，然后正常启动 Claude Code 会话，HUD 会自动检测并显示。

## 项目结构

```
claude-hud/
├── app/
│   ├── api/
│   │   ├── sessions/route.ts          # 获取所有会话列表 + 统计
│   │   ├── sessions/[id]/route.ts     # 获取单个会话详情
│   │   └── tools/route.ts             # 获取工具注册信息
│   ├── components/
│   │   ├── session-selector.tsx        # 左侧会话选择器
│   │   ├── session-header.tsx          # 会话头部（标题、状态、持续时间）
│   │   ├── cost-display.tsx            # 费用估算卡片
│   │   ├── token-chart.tsx             # Token 用量柱状图（Recharts）
│   │   ├── tool-usage-panel.tsx        # 工具使用面板（带进度条）
│   │   ├── message-timeline.tsx        # 会话消息时间线
│   │   └── file-changes.tsx            # 文件变更列表
│   ├── page.tsx                        # 主仪表盘页面
│   └── layout.tsx                      # 根布局
├── lib/
│   ├── types.ts                        # TypeScript 类型定义
│   ├── claude-session.ts              # 会话管理器类（核心逻辑）
│   ├── session-store.ts               # 单例会话存储
│   ├── cost-calculator.ts             # 费用计算工具
│   └── tool-registry.ts              # 工具注册表（分类、图标）
└── package.json
```

## 核心架构

### 数据流

```
Claude Code SDK (数据源)
    │
    ▼
ClaudeSessionManager (核心类)
    │  - 管理会话的创建、消息添加
    │  - Token 累计计算
    │  - 文件变更追踪
    │  - 会话完成处理
    │
    ▼
SessionStore (单例存储)
    │  - 全局管理器实例
    │
    ▼
Next.js API Routes (后端)
    │  - /api/sessions — 会话列表
    │  - /api/sessions/[id] — 会话详情
    │  - /api/tools — 工具注册信息
    │
    ▼
React Components (前端)
    │  - 轮询间隔: 会话列表 3 秒, 单会话详情 2 秒
    │
    ▼
浏览器仪表盘 (UI)
```

### 关键组件说明

**ClaudeSessionManager** — 核心类

管理单个 Claude Code 会话的完整生命周期：

- 创建会话时初始化统计数据
- 添加消息时累计 token 用量
- 追踪文件读写操作
- 记录工具调用历史
- 会话结束时标记完成状态

**CostCalculator** — 费用计算

支持三种模型的定价计算：

| 模型 | Input Token | Output Token |
|------|------------|-------------|
| claude-sonnet-4 | $3 / 1M | $15 / 1M |
| claude-haiku | $0.25 / 1M | $1.25 / 1M |
| claude-opus | $15 / 1M | $75 / 1M |

**ToolRegistry** — 工具注册表

预定义的工具信息（分类、图标）：

| 工具 | 分类 | 图标 |
|------|------|------|
| file_read | 文件操作 | 📖 |
| file_write | 文件操作 | ✏️ |
| file_edit | 文件操作 | 📝 |
| bash | 终端 | 💻 |
| search | 搜索 | 🔍 |
| glob | 搜索 | 📁 |
| grep | 搜索 | 🔎 |

## 当前限制

- **轮询机制**: 使用 `setInterval` 轮询，非 WebSocket/SSE 实时推送
- **内存存储**: 会话数据存储在内存中，重启后丢失
- **无持久化**: 没有数据库，不适合长期存储
- **无认证**: 没有身份验证机制
- **早期版本**: 0.1.0，功能还在完善中

## 适用场景

- **开发调试**: 实时观察 Claude Code 的工作过程
- **费用监控**: 追踪 Token 消耗和预估费用
- **效率分析**: 了解 Claude 使用了哪些工具，哪些操作耗时最多
- **多任务管理**: 同时监控多个并行的 Claude Code 会话

## 与 Hermes Agent 的对比

| 维度 | Claude HUD | Hermes Agent |
|------|-----------|-------------|
| 数据源 | Claude Code SDK | 内置 |
| 实时性 | 轮询 (2-3 秒) | 实时 |
| 费用追踪 | ✅ 支持三种模型 | ✅ 内置 |
| 工具追踪 | ✅ 可视化 | ✅ 日志 |
| 会话管理 | 多会话 | 单会话 |
| 持久化 | ❌ 内存存储 | ✅ Session 存储 |
| 部署方式 | 独立 Web 应用 | CLI 内置 |

## 参考来源

- [GitHub - jarrodwatts/claude-hud](https://github.com/jarrodwatts/claude-hud)
- [Claude Code SDK - @anthropic-ai/claude-code](https://www.npmjs.com/package/@anthropic-ai/claude-code)
- [Next.js 15 Documentation](https://nextjs.org/docs)
- [Anthropic - Claude Code](https://docs.anthropic.com/en/docs/claude-code)
