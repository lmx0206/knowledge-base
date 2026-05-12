# GPT 回答：Claude Code + Codex Desktop + Superpowers 多 Agent 协作工作流

> 提问者：mason
> 来源：ChatGPT Plus (GPT-5)
> 时间：2026年5月

## 核心观点

Claude Code + Opus 4.7 = 架构师 / 方案负责人 / Code Reviewer
Codex Desktop = 执行工程师 / 写代码 / 跑测试 / 修编译错误
Superpowers = 给两个 Agent 套上流程纪律

## 1. 核心原则：靠仓库文件同步，不靠聊天上下文

在项目仓库创建 AI 共同读取的项目知识库：

```
docs/ai-migration/
  00-project-context.md          # 项目背景、技术栈、模块结构
  01-flutter-inventory.md        # Flutter 模块盘点
  02-native-architecture.md      # 原生实现架构方案
  03-migration-plan.md           # 总迁移计划
  04-task-board.md               # 任务拆分与状态
  05-decisions.md                # 架构决策记录
  06-parity-checklist.md         # UI/交互/业务一致性验收清单
  07-test-plan.md                # 测试计划
  08-progress-log.md             # 每次 Agent 执行后的同步日志

CLAUDE.md                        # Claude Code 持久规则
AGENTS.md                        # Codex 持久规则
```

## 2. 角色分工

### Claude Code / Opus 4.7

- 阅读 Flutter 模块，分析页面、路由、状态、接口、模型、埋点、缓存、平台通道
- 输出 Android 原生迁移方案
- 拆任务，写验收标准
- 审查 Codex 写出来的 diff
- 发现架构偏差、业务遗漏、UI/交互不一致
- 更新 docs/ai-migration/ 里的决策和进度
- 不要一边规划一边大改代码

### Codex Desktop

- 按 task-board 领取一个小任务
- 只改任务相关文件
- 写 Kotlin / Java 原生代码
- 补测试或最小验证用例
- 跑 build / lint / 单测
- 修复编译错误
- 更新 progress-log
- 给出变更摘要

## 3. Superpowers 用法

Claude Code 用 /brainstorm 讨论方案、/write-plan 生成计划
Codex 用 Superpowers 执行流程约束：先读计划 → 实现 → 测试 → review → 更新进度

## 4. 五阶段工作流

1. Claude 做 Flutter 盘点 → 输出 01-flutter-inventory.md
2. Claude 写迁移总方案 → 输出 02~07 文档
3. Codex 按任务执行 → 一次一个 task，跑验证
4. Claude Review Codex 的 diff → 输出修复意见
5. Codex 修 review 问题 → 重新跑验证

## 5. 任务拆分建议

```
T001：迁移数据模型 / DTO / 字段映射
T002：迁移 Repository / API 调用
T003：迁移 ViewModel / Presenter 状态流
T004：迁移主页面静态 UI
T005：迁移列表 / 分页 / 刷新
T006：迁移 loading / empty / error 状态
T007：迁移点击事件 / 跳转 / 弹窗
T008：迁移埋点 / 日志 / 权限 / 平台能力
T009：补齐异常场景
T010：截图对比和最终验收
```

## 6. 每日节奏

- 早上：Claude 拆今天 2~4 个小任务，明确验收标准
- 开发时：Codex 一个线程做一个 Task，独立 worktree/branch
- 每完成一个任务：Claude review diff，输出修复意见
- 修复后：Codex 按 review 意见 patch，再跑 build/test
- 下班前：Claude 总结今天完成内容，更新 task-board，生成明天任务

## 7. 最终工作流

Claude 负责"想清楚" → Codex 负责"写出来" → Claude 负责"挑毛病" → Codex 负责"修到过" → 你负责"确认产品行为和业务边界"

## 参考来源

- [1] https://code.claude.com/docs/en/best-practices
- [2] https://developers.openai.com/codex/app
- [3] https://developers.openai.com/codex/guides/agents-md
- [4] https://www.anthropic.com/news/claude-opus-4-7
- [5] https://developers.openai.com/codex/ide
- [6] https://developers.openai.com/codex/cli
- [7] https://developers.openai.com/codex/learn/best-practices
- [8] https://github.com/obra/superpowers-marketplace
- [9] https://github.com/obra/superpowers
