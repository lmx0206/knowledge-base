# AI 终端编码 Agent 三大工具对比与组合使用指南

> 创建时间：2026年5月
> 涵盖：Claude Code、Codex CLI、Gemini CLI
> 针对场景：移动端开发（Android/Flutter）

## 概述

2026 年，三大 AI 终端编码 Agent 并驾齐驱：

```
┌──────────────┬──────────────┬──────────────┐
│ Claude Code  │ Codex CLI    │ Gemini CLI   │
│ Anthropic    │ OpenAI       │ Google       │
│ 2025         │ 2026         │ 2026         │
│ 最强推理     │ 最快执行     │ 最大方免费   │
└──────────────┴──────────────┴──────────────┘
```


══════════════════════════════════════════════
  核心差异一览
══════════════════════════════════════════════

```
┌─────────────────┬──────────────┬──────────────┬──────────────┐
│ 维度             │ Claude Code  │ Codex CLI    │ Gemini CLI   │
├─────────────────┼──────────────┼──────────────┼──────────────┤
│ 核心优势         │ 推理最强     │ 执行最快     │ 免费最多     │
│ 模型             │ Claude 4     │ GPT-5        │ Gemini 3     │
│ 上下文窗口       │ 200K tokens  │ 128K tokens  │ 1M tokens    │
│ 实现语言         │ TypeScript   │ Rust         │ TypeScript   │
│ 配置格式         │ JSON         │ TOML         │ JSON         │
│ 项目文件         │ CLAUDE.md    │ AGENTS.md    │ GEMINI.md    │
│ 免费额度         │ 需 API Key   │ ChatGPT 计划 │ 1000次/天    │
│ 沙箱             │ ❌           │ ✅ 内置      │ ✅ 内置      │
│ MCP 客户端       │ ✅           │ ✅           │ ✅           │
│ MCP 服务器       │ ❌           │ ✅ 实验性    │ ❌           │
│ Skills           │ ✅           │ ✅           │ ✅ Extensions│
│ Hooks            │ ✅ 12 事件   │ ✅ 通知型    │ ✅ 11 事件   │
│ 搜索能力         │ ❌           │ ❌           │ ✅ Google    │
│ 多模态           │ ✅ 图片      │ ✅ 图片      │ ✅ 图片/PDF  │
│ 会话回退         │ ❌           │ ❌           │ ✅ Checkpoint│
│ GitHub Action    │ ❌           │ ❌           │ ✅ 原生      │
│ 非交互模式       │ --print      │ codex exec   │ --headless   │
│ 子代理           │ ✅           │ ✅           │ ✅ 实验性    │
│ 跨工具 Skills    │ ❌ .claude/  │ ❌           │ ✅ .agents/  │
└─────────────────┴──────────────┴──────────────┴──────────────┘
```


══════════════════════════════════════════════
  各工具的长处与短处
══════════════════════════════════════════════

### Claude Code — 推理之王

```
长处：
  ✅ 推理能力最强，复杂逻辑分析最佳
  ✅ 代码质量最高，架构设计能力突出
  ✅ Hooks 系统最完善（12 种事件）
  ✅ Superpowers 集成最成熟
  ✅ 社区生态最丰富
  ✅ CLAUDE.md 写法最灵活

短处：
  ❌ 没有免费额度，必须有 API Key
  ❌ 没有内置沙箱
  ❌ 没有搜索能力
  ❌ 没有会话回退
  ❌ 上下文窗口 200K（比 Gemini 小）
  ❌ 没有 GitHub Action
```

### Codex CLI — 速度之王

```
长处：
  ✅ Rust 实现，启动最快，内存最低
  ✅ 内置沙箱安全系统（三种模式）
  ✅ ChatGPT 计划包含使用（无需额外付费）
  ✅ MCP 服务器模式（可被其他 Agent 调用）
  ✅ codex exec 非交互模式最完善
  ✅ WSL2 自动 Toast 通知
  ✅ DotSlash 版本锁定

短处：
  ❌ 上下文窗口 128K（三者中最小）
  ❌ 没有搜索能力
  ❌ 没有会话回退
  ❌ 没有 GitHub Action
  ❌ Hooks 系统较简单（通知型）
  ❌ 外部贡献受限（非开放贡献）
```

### Gemini CLI — 免费之王

```
长处：
  ✅ 免费额度最大方（1000次/天）
  ✅ 100 万 token 上下文窗口
  ✅ 内置 Google Search Grounding
  ✅ 会话检查点和回退
  ✅ 原生 GitHub Action
  ✅ 多模态最强（图片/PDF/草图）
  ✅ Extensions 扩展系统
  ✅ Agent Skills 跨工具兼容（.agents/）
  ✅ 三种发布渠道（stable/preview/nightly）

短处：
  ❌ 推理能力略逊于 Claude
  ❌ 执行速度不如 Codex（TypeScript）
  ❌ MCP 服务器支持不如 Codex 完善
  ❌ 企业功能需要 Vertex AI
  ❌ 仍在快速迭代，API 可能变化
```


══════════════════════════════════════════════
  什么情况下用哪个？
══════════════════════════════════════════════

### 场景选择指南

```
┌─────────────────────────┬──────────────────────────────┐
│ 场景                     │ 推荐工具                      │
├─────────────────────────┼──────────────────────────────┤
│ 复杂架构设计             │ Claude Code（推理最强）       │
│ 代码审查和重构           │ Claude Code（质量最高）       │
│ 调试复杂 bug             │ Claude Code + Codex          │
│ 日常快速开发             │ Codex CLI（执行最快）         │
│ CI/CD 自动化             │ Codex exec 或 Gemini Action  │
│ 学习和探索               │ Gemini CLI（免费最多）        │
│ 大型代码库分析           │ Gemini CLI（1M 上下文）       │
│ 需要搜索最新信息         │ Gemini CLI（Google 搜索）     │
│ 从图片/PDF 生成代码      │ Gemini CLI（多模态最强）      │
│ 团队协作 PR 审查         │ Gemini CLI（GitHub Action）   │
│ 安全敏感环境             │ Codex CLI（沙箱最完善）       │
│ 预算有限                 │ Gemini CLI（免费）            │
│ 已有 ChatGPT 计划        │ Codex CLI（包含在计划中）     │
│ 需要最长上下文           │ Gemini CLI（1M tokens）       │
│ 需要最强推理             │ Claude Code（Claude 4）       │
└─────────────────────────┴──────────────────────────────┘
```


══════════════════════════════════════════════
  如何组合使用？
══════════════════════════════════════════════

### 组合策略 1：Claude Code + Gemini CLI（推荐）

```
日常开发用 Claude Code（推理强）
免费探索用 Gemini CLI（额度大方）

具体做法：
  1. 写好 AGENTS.md + GEMINI.md（共享项目上下文）
  2. 复杂任务用 Claude Code
  3. 快速查询、学习、探索用 Gemini CLI
  4. PR 审查用 Gemini CLI GitHub Action
```

### 组合策略 2：Codex CLI + Claude Code

```
执行用 Codex（快），推理用 Claude（强）

具体做法：
  1. Codex 做日常编码（ChatGPT 计划包含）
  2. Claude Code 做架构设计和代码审查
  3. Codex 的 MCP 服务器模式可以让 Claude 调用
  4. 共享 AGENTS.md
```

### 组合策略 3：三工具全用

```
每个工具发挥所长：

┌─────────────────────────────────────────────────┐
│  工作流                                          │
│                                                  │
│  1. 需求分析 → Gemini CLI（搜索 + 多模态）       │
│  2. 架构设计 → Claude Code（推理最强）           │
│  3. 编码实现 → Codex CLI（执行最快）             │
│  4. 代码审查 → Claude Code（质量最高）           │
│  5. PR 管理 → Gemini CLI（GitHub Action）        │
│  6. 文档生成 → Gemini CLI（免费 + 长上下文）     │
│  7. CI/CD → Codex exec 或 Gemini headless        │
└─────────────────────────────────────────────────┘
```

### 组合策略 4：Hermes Agent 作为中枢

```
Hermes Agent 作为统一入口，按需调用：

┌─────────────────────────────────────────────────┐
│  Hermes Agent（中枢）                            │
│  ├── 日常对话 → mimo-v2.5-pro（免费）           │
│  ├── 代码任务 → 委派给 Claude Code / Codex      │
│  ├── 搜索任务 → Gemini CLI（Google 搜索）       │
│  ├── 图像分析 → Gemini（多模态）                 │
│  ├── 定时任务 → Hermes cron jobs                 │
│  └── 跨会话记忆 → Hermes Memory 系统            │
└─────────────────────────────────────────────────┘
```


══════════════════════════════════════════════
  共享上下文：跨工具兼容
══════════════════════════════════════════════

### 项目文件对照

```
Claude Code:  CLAUDE.md        .claude/skills/
Codex CLI:    AGENTS.md        codex 插件
Gemini CLI:   GEMINI.md        .gemini/skills/ 或 .agents/skills/
Hermes:       AGENTS.md        ~/.hermes/skills/
```

### 跨工具共享 Skills

```
Gemini CLI 的 .agents/skills/ 目录可以被多个工具识别。
建议：
  1. 在 .agents/skills/ 中创建通用 Skills
  2. 为各工具创建特定的配置文件
  3. 保持 Skills 内容通用，配置文件特定
```

### 共享 AGENTS.md

```
Claude Code 可以配置读取 AGENTS.md：
  // .claude/settings.json
  {"context": {"fileName": ["AGENTS.md", "CLAUDE.md"]}}

Gemini CLI 可以配置读取 AGENTS.md：
  // .gemini/settings.json
  {"context": {"fileName": ["AGENTS.md", "GEMINI.md"]}}

这样一份 AGENTS.md 可以被三个工具共享！
```


══════════════════════════════════════════════
  成本对比
══════════════════════════════════════════════

```
┌─────────────────┬────────────────────────────────┐
│ 工具             │ 成本                           │
├─────────────────┼────────────────────────────────┤
│ Claude Code     │ 需 API Key                     │
│                 │ 输入 $3-15/百万 token           │
│                 │ 输出 $15-75/百万 token          │
│                 │ Sonnet 4: $3/$15               │
│                 │ Opus 4: $15/$75                │
├─────────────────┼────────────────────────────────┤
│ Codex CLI       │ ChatGPT Plus $20/月 包含       │
│                 │ ChatGPT Pro $200/月 包含        │
│                 │ 或 API Key 按 token 计费        │
├─────────────────┼────────────────────────────────┤
│ Gemini CLI      │ Google 账号：免费 1000次/天     │
│                 │ API Key：免费 1000次/天         │
│                 │ Vertex AI：按量计费             │
├─────────────────┼────────────────────────────────┤
│ 最佳性价比      │ Gemini CLI（免费）              │
│ 最佳质量        │ Claude Code（需付费）           │
│ 最佳平衡        │ Codex CLI（ChatGPT 计划）       │
└─────────────────┴────────────────────────────────┘
```


══════════════════════════════════════════════
  总结：选择建议
══════════════════════════════════════════════

```
预算为 0：
  → Gemini CLI（免费 1000次/天）
  → 补充：Claude Code 偶尔付费做复杂任务

已有 ChatGPT 计划：
  → Codex CLI（包含在计划中）
  → 补充：Gemini CLI 做搜索和多模态

追求最高质量：
  → Claude Code（推理最强）
  → 补充：Gemini CLI 做免费探索

团队协作：
  → Gemini CLI（GitHub Action + .agents/ 兼容）
  → 补充：Claude Code 做代码审查

Android/Flutter 开发：
  → Claude Code（架构设计）+ Codex CLI（日常编码）
  → 共享 AGENTS.md
```


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Anthropic Claude Code 官方文档
    https://docs.anthropic.com/en/docs/claude-code

[2] OpenAI Codex 官方文档
    https://developers.openai.com/codex

[3] Google Gemini CLI 官方文档
    https://geminicli.com/docs/

[4] obra/superpowers GitHub 仓库
    https://github.com/obra/superpowers

[5] Model Context Protocol 规范
    https://modelcontextprotocol.io

[6] agentskills.io 开放标准
    https://agentskills.io
