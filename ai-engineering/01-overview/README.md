# AI 工程三大演变：从提示词到驾驭

> 更新时间：2026年5月
> 作者：mason 的 AI 知识库

## 概述

AI 交互方式经历了三个关键阶段的演变：

```
2022-2024          2025              2026
┌──────────┐   ┌──────────┐   ┌──────────────┐
│ Prompt   │──>│ Context  │──>│  Harness     │
│ Eng.     │   │ Eng.     │   │  Engineering │
│ 提示词    │   │ 上下文    │   │  驾驭工程    │
└──────────┘   └──────────┘   └──────────────┘
  "怎么问"      "给什么信息"    "整个系统怎么搭"
```

## 核心区别（一句话版本）

- **提示词工程**：怎么写好一个问题 → 写好邮件内容
- **上下文工程**：给模型什么信息 → 给邮件加上附件、背景资料
- **驾驭工程**：整个工作环境怎么设计 → 设计整个办公室的流程

## 核心区别（详细版本）

### 1. 提示词工程 (Prompt Engineering) — 2022-2024
- 关注点：单次输入的质量
- 核心技术：Few-shot、Chain-of-Thought、角色扮演
- 目标：写出完美的提示词，获得最佳单次输出
- 局限：无法处理复杂、长周期的任务

### 2. 上下文工程 (Context Engineering) — 2025
- 提出者：Andrej Karpathy 等人
- 关注点：动态构建上下文窗口
- 核心技术：RAG、记忆系统、工具定义、对话历史管理
- 目标：让模型在正确的时刻看到正确的信息
- 关键洞察："上下文工程比提示词工程重要得多"

### 3. 驾驭工程 (Harness Engineering) — 2026
- 提出者：Mitchell Hashimoto（Terraform 创始人）
- 关注点：Agent 运行的整个环境
- 核心技术：规则文件、反馈循环、质量门禁、工具链、生命周期管理
- 目标：让 Agent 持续、可靠、高质量地工作
- 关键洞察："Agent 不难，难的是 Harness"

## 为什么演变发生了？

```
模型能力：  弱 ──────────────────────────────────> 强
           │                                      │
人的角色：  写提示词 → 管理上下文 → 设计系统环境    │
           │                                      │
瓶颈：     模型不懂 → 模型信息不够 → 模型不可靠     │
```

当模型变得足够强大时，问题不再是"它能不能做"，而是"怎么让它可靠地做"。

## 关键数据

- OpenAI Codex 团队：7人用 GPT-5 生成 100万行代码，0行人工编写
- Stripe "Minions" 系统：每周自动合并 1,300+ 个 PR
- 相同模型+相同数据，仅改变运行环境，成功率从 42% 跳到 78%

## 在 Hermes Agent 中的体现

| 概念 | Hermes 对应功能 |
|------|----------------|
| 提示词工程 | system prompt、personality 配置 |
| 上下文工程 | Memory 系统、Skills、AGENTS.md、session_search |
| 驾驭工程 | 工具链、cron jobs、delegation、gateway、反馈循环 |

## 目录结构

```
ai-engineering/
├── 01-overview/          ← 你在这里
├── 02-prompt-engineering/  提示词工程详解
├── 03-context-engineering/ 上下文工程详解
├── 04-harness-engineering/ 驾驭工程详解
├── 05-practical-tools/     实用工具与配置
├── 06-hermes-agent/        Hermes Agent 专属实践
└── 07-references/          参考资料与链接
```

## 参考来源

- Martin Fowler: "Harness engineering for coding agent users" (2026.04)
- Louis Bouchard: "Harness Engineering: The Missing Layer Behind AI Agents"
- Epsilla: "Why Harness Engineering Replaced Prompting in 2026"
- Anthropic: "Effective context engineering for AI agents"
- Mitchell Hashimoto: Engineer the Harness (2026.02)
- OpenAI Codex 团队内部实验报告
