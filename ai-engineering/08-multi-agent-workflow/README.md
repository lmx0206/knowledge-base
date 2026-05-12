# 多 Agent 协作工作流：Claude Code + Codex Desktop + Superpowers

> 创建时间：2026年5月12日
> 适用场景：Flutter → Android 原生迁移（可推广到任何跨技术栈迁移）
> 来源：GPT-5 与 Claude Opus 4.7 的回答对比分析

## 这是什么？

当你同时拥有 Claude Pro (Opus 4.7) 和 ChatGPT Plus (Codex Desktop)，
并且安装了 Superpowers 插件时，如何让它们高效协作完成一个大型迁移项目？

本文档综合了 GPT-5 和 Claude Opus 4.7 两个 AI 的建议，
提炼出一套经过验证的多 Agent 协作工作流。

## 文档导航

| 文档 | 内容 |
|------|------|
| [gpt-original.md](gpt-original.md) | GPT-5 的原始回答 |
| [claude-original.md](claude-original.md) | Claude Opus 4.7 的原始回答 |
| [analysis-and-summary.md](analysis-and-summary.md) | **对比分析 + 合并工作流（推荐先读这个）** |

## 核心共识（一句话）

用 Git 仓库文件做"共享大脑"，用 Superpowers 做"共享纪律"，用角色分工做"质量保障"。

## 快速开始

1. 读 [analysis-and-summary.md](analysis-and-summary.md) 了解完整工作流
2. 按文档中的 CLAUDE.md 模板配置你的项目
3. symlink: `ln -s CLAUDE.md AGENTS.md`
4. 安装 Superpowers（两边都装）
5. 开始第一个 feature 的 brainstorm

## 参考来源

- [1] GPT-5 回答（ChatGPT Plus，2026年5月）
- [2] Claude Opus 4.7 回答（Claude Pro，2026年5月）
- [3] https://github.com/obra/superpowers
- [4] https://code.claude.com/docs/en/best-practices
- [5] https://developers.openai.com/codex/guides/agents-md
