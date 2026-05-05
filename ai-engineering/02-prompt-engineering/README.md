# 提示词工程 (Prompt Engineering)

> 阶段：2022-2024（第一代）
> 核心问题：怎么让 AI 听懂你的话？

## 什么是提示词工程？

提示词工程是设计和优化输入给 AI 模型的文本，以获得最佳输出的技术。
它是与 AI 交互的第一个系统性方法论。

## 核心技术

### 1. 基础技巧

```
【角色设定】
你是一个资深的 Android 开发工程师，精通 Kotlin 和 Jetpack Compose。

【任务描述】
帮我优化以下 ViewModel 代码的性能。

【输出格式】
请用 markdown 代码块展示，并在关键改动处加注释。
```

### 2. Few-shot（少样本学习）

给 AI 几个示例，让它学会模式：

```
输入：hello → 输出：你好
输入：thank you → 输出：谢谢
输入：goodbye → 输出：
```

### 3. Chain-of-Thought（思维链）

让 AI 一步步思考：

```
请一步步思考：
1. 首先分析问题的核心
2. 然后列出可能的方案
3. 最后给出推荐方案及理由
```

### 4. 角色扮演

```
你是一个有 10 年经验的 Flutter 架构师。
请以这个身份审查我的代码架构。
```

### 5. 约束与格式控制

```
请按以下 JSON 格式返回：
{
  "summary": "一句话总结",
  "issues": ["问题1", "问题2"],
  "suggestion": "建议"
}
```

## 提示词工程的局限

| 问题 | 原因 |
|------|------|
| 长对话后"失忆" | 没有记忆管理机制 |
| 重复犯同样的错 | 没有反馈循环 |
| 复杂任务做不好 | 单次提示无法处理多步骤 |
| 不了解你的项目 | 没有上下文注入机制 |
| 输出质量不稳定 | 依赖模型的"理解能力" |

## 何时仍然有效？

- 简单的单次问答
- 快速原型和实验
- 格式化输出控制
- 与非 Agent 型 AI 交互（如 ChatGPT 网页版）

## 在 Hermes 中的对应

| 提示词技巧 | Hermes 功能 |
|-----------|------------|
| 角色设定 | `~/.hermes/config.yaml` 中的 personality |
| 任务模板 | Skills（技能文件） |
| 格式控制 | 工具的 schema 定义 |
| 思维链 | reasoning level 设置 |

## 推荐阅读

- OpenAI GPT-4.1 Prompting Guide
- Anthropic Claude Prompt Engineering Guide
- Prompt Engineering Guide (promptingguide.ai)
