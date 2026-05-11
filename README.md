# mason 的 AI 知识库

> 创建时间：2026年5月
> 维护者：Hermes Agent (mimo-v2.5-pro)
> GitHub：https://github.com/lmx0206/knowledge-base

## 目录结构

```
knowledge-base/
├── cloud-deployment/        ← 免费云服务器部署指南
│   └── README.md            Oracle Cloud + Hermes Agent 部署
├── superpowers/             ← Superpowers 技能框架
│   └── README.md            安装、工作流、技能库、设计哲学
├── openspec/                ← OpenSpec 规格驱动开发
│   └── README.md            安装、3步工作流、最佳实践
├── claude-code/             ← Claude Code 完整指南
│   ├── README.md            总览与目录
│   ├── claude-md.md         CLAUDE.md 配置详解
│   ├── skills.md            技能系统
│   ├── mcp.md               MCP 服务器集成
│   ├── hooks.md             Hooks 自动化
│   ├── save-tokens.md       节省 Token 策略
│   └── tips-and-tricks.md   技巧与最佳实践
├── ghostty/                 ← Ghostty 终端使用指南
│   ├── README.md            概述
│   ├── shortcuts.md         完整快捷键参考（macOS）
│   ├── config-guide.md      配置文件详解
│   └── tips-and-tricks.md   技巧与进阶用法
├── codex/                 ← Codex CLI 完整指南
│   ├── README.md            总览与目录
│   ├── skills.md            技能系统（Superpowers）
│   ├── mcp.md               MCP 服务器集成
│   ├── hooks.md             Hooks 与自动化
│   ├── save-tokens.md       节省 Token 策略
│   └── tips-and-tricks.md   技巧与最佳实践
├── gemini-cli/            ← Gemini CLI 完整指南
│   ├── README.md            总览与目录
│   ├── skills.md            技能系统（Skills + Extensions）
│   ├── mcp.md               MCP 服务器集成
│   ├── save-tokens.md       节省 Token 策略
│   └── tips-and-tricks.md   技巧与最佳实践
├── ai-comparison/         ← 三大工具对比与组合使用
│   └── README.md            差异对比 + 场景选择 + 组合策略
└── ai-engineering/          ← AI 工程三大演变
    ├── 01-overview/          总览
    ├── 02-prompt-engineering/ 提示词工程
    ├── 03-context-engineering/ 上下文工程
    ├── 04-harness-engineering/ 驾驭工程
    ├── 05-practical-tools/    实用工具与配置
    ├── 06-hermes-agent/       Hermes + Flutter/Android 指南
    ├── 07-references/         参考资料
    └── templates/             可复制的项目模板
        ├── flutter/
        └── android/
```

## 快速导航

| 我想... | 去看 |
|---------|------|
| 免费部署 Hermes Agent 到云服务器 | cloud-deployment/ |
| 安装 Superpowers | superpowers/ |
| 使用 OpenSpec 做规格驱动开发 | openspec/ |
| 学习 Claude Code | claude-code/ |
| 节省 Claude Code Token | claude-code/save-tokens.md |
| 配置 Claude Code 的 Skills/MCP/Hooks | claude-code/skills.md, mcp.md, hooks.md |
| 学习 Ghostty 终端 | ghostty/ |
| 查 Ghostty 快捷键 | ghostty/shortcuts.md |
| 学习 Codex CLI | codex/ |
| 节省 Codex Token | codex/save-tokens.md |
| 学习 Gemini CLI | gemini-cli/ |
| 节省 Gemini Token | gemini-cli/save-tokens.md |
| 三大工具对比 | ai-comparison/ |
| 如何组合使用 AI 工具 | ai-comparison/README.md |
| 了解 AI 工程三大演变 | ai-engineering/01-overview/ |
| 搭建大型 Android Agent Harness | ai-engineering/04-harness-engineering/android-agent-harness.md |
| 让 AI Agent 理解我的项目 | ai-engineering/06-hermes-agent/flutter-android-harness-guide.md |
| 拿模板直接用 | ai-engineering/templates/ |

## 核心公式

```
弱模型 + 好上下文 + 好驾驭 ≈ 强模型 + 糟糕配置
```

## 使用方式

- 每个文件夹都有 README.md，直接阅读即可
- 遇到新的知识，告诉我"更新知识库"
- 所有内容都有引用来源，确保可溯源

## 开发环境

```bash
git clone https://github.com/lmx0206/knowledge-base.git
cd knowledge-base
npm install          # 安装依赖 + 自动启用 pre-commit hook
```

`npm install` 会通过 Husky 自动安装 pre-commit hook，提交时会检查：

- Markdown 格式（markdownlint）
- 引用来源章节是否存在

跳过检查：`git commit --no-verify`
