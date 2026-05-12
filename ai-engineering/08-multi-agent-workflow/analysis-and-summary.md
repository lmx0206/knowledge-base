# Claude Code + Codex Desktop + Superpowers 多 Agent 协作：对比分析与工作流总结

> 创建时间：2026年5月12日
> 来源：GPT-5 (ChatGPT Plus) 与 Claude Opus 4.7 的回答对比分析
> 适用场景：Flutter → Android 原生迁移

══════════════════════════════════════════════
  一、两份回答的核心共同点
══════════════════════════════════════════════

GPT 和 Claude 的回答在以下 6 个关键点上完全一致：

| # | 共识点 | GPT 原话 | Claude 原话 |
|---|--------|----------|-------------|
| 1 | **仓库文件是唯一同步中心** | "不要靠聊天上下文同步，要靠仓库文件同步" | "让仓库本身成为共享内存" |
| 2 | **角色分工一致** | Claude=架构师, Codex=执行工程师 | Claude=规划, Codex=执行 |
| 3 | **CLAUDE.md + AGENTS.md 双配置** | 分别写两份配置文件 | 建议 symlink 保持一致 |
| 4 | **Superpowers 统一流程纪律** | 给两个 Agent 套流程纪律 | 两边都装，方法论不跳变 |
| 5 | **小任务拆分** | 每个 Task 足够小 | 每个 task 2-5 分钟 |
| 6 | **不要让 Agent 独自从头干到尾** | Claude 规划→Codex→Claude 审查→Codex 修复 | 任何不能写进文件的上下文都不要跨 Agent 传递 |

**核心共识一句话**：用 Git 仓库文件做"共享大脑"，用 Superpowers 做"共享纪律"，用角色分工做"质量保障"。


══════════════════════════════════════════════
  二、关键差异对比
══════════════════════════════════════════════

| 维度 | GPT 方案 | Claude 方案 | 分析 |
|------|----------|-------------|------|
| **文档结构** | 8 个编号文件 (00~08) | 4 类目录 (specs/plans/docs/ADR) | GPT 更详细，Claude 更简洁 |
| **Symlink** | 未提及 | ln -s CLAUDE.md AGENTS.md | Claude 更务实，避免漂移 |
| **Delta 文件机制** | 未提及 | plan 有误→停→写 delta→等指示 | Claude 的重要创新，防止 Agent 偏离 |
| **技术栈选择** | 未指定（尊重现有架构） | 明确建议 Compose + Hilt + Room | Claude 更激进，GPT 更保守 |
| **每日节奏** | 有明确时间线 | 无，按 feature 循环 | GPT 更适合团队管理 |
| **迁移坑提示** | 通用质量清单 | 具体 Flutter→Android 映射表 | Claude 更专业，给出具体等价物 |
| **Session 保留** | 未提及 | 导出 transcript 到 docs/sessions/ | Claude 考虑了知识传承 |
| **MCP 插件** | 未提及 | 建议装 Context7 | Claude 考虑了 API 文档实时性 |
| **质量清单** | 详细的 UI/交互/业务/工程 4 维检查表 | 以 ADR + 测试为主 | GPT 更适合 QA 验收 |

**差异本质**：GPT 偏"项目管理视角"（任务拆分、每日节奏、验收清单），Claude 偏"工程架构视角"（Delta 机制、技术映射、Session 归档）。两者互补，不矛盾。


══════════════════════════════════════════════
  三、合并后的最佳实践清单
══════════════════════════════════════════════

综合两份回答，以下是最优做法：

### 3.1 仓库文件结构（采用 GPT 的编号 + Claude 的目录分类）

```
项目根目录/
├── CLAUDE.md                          ← Claude Code system prompt
├── AGENTS.md                          ← symlink → CLAUDE.md（采用 Claude 建议）
├── PROGRESS.md                        ← 当前进度（采用 Claude 命名）
│
├── docs/
│   ├── ai-migration/
│   │   ├── 00-project-context.md      ← 项目背景
│   │   ├── 01-flutter-inventory.md    ← Flutter 模块盘点
│   │   ├── 02-native-architecture.md  ← 原生架构方案
│   │   ├── 03-migration-plan.md       ← 总迁移计划
│   │   ├── 04-task-board.md           ← 任务看板
│   │   ├── 05-decisions.md            ← ADR 架构决策
│   │   ├── 06-parity-checklist.md     ← 一致性验收清单
│   │   └── 07-test-plan.md            ← 测试计划
│   ├── adr/                           ← 独立 ADR 文件
│   └── sessions/                      ← Agent 会话归档（采用 Claude 建议）
│
├── specs/                             ← 需求规格（brainstorm 产物）
├── plans/                             ← 实施计划（write-plan 产物）
│   └── *.delta.md                     ← 执行偏差记录（采用 Claude Delta 机制）
```

### 3.2 CLAUDE.md / AGENTS.md 核心规则

```markdown
# 角色分工
- 规划阶段 (brainstorm + write-plan) 由 Claude Code (Opus 4.7) 完成
- 执行阶段 (execute-plan) 由 Codex Desktop 完成

# 硬约束
1. 一次迁移一个 feature module，不跨模块
2. 严格 TDD：先写失败测试 → 写最少代码通过 → 重构
3. 行为对等优先于代码相似，不要逐行翻译 Dart
4. 任何与 Flutter 原行为的偏差必须记入 ADR
5. 如执行中发现 plan 有误，**停止**并写 plans/<feature>.delta.md，不要自行偏离
6. 任何不能写进文件的上下文都不要跨 Agent 传递

# 代码质量门禁
- All tests green
- ktlint + detekt clean
- 不引入新的 TODO 而不写 issue 编号
- commit message 带 plan task ID

# 常用命令
- Build: ./gradlew :app:assembleDebug
- Test: ./gradlew test
- Lint: ./gradlew ktlintCheck detekt

# 必读文件
每次开始前必须阅读：
- PROGRESS.md
- docs/ai-migration/04-task-board.md
- docs/ai-migration/05-decisions.md
```

### 3.3 五阶段工作流（合并版）

```
阶段 1：Brainstorm（Claude Code）
  → 苏格拉底式提问，固化需求到 specs/<feature>.md
  → 不写代码

阶段 2：Write Plan（Claude Code）
  → 拆任务到 plans/<feature>.md
  → 每个 task 2-5 分钟
  → TDD 顺序
  → 人工 review plan ← 这是最大的质量红利

阶段 3：Execute（Codex Desktop）
  → 按 plan 顺序执行
  → TDD red/green/refactor
  → 每个 task 跑 build/test 后 commit
  → plan 有误 → 停 → 写 delta.md

阶段 4：Review（Claude Code）
  → review git diff
  → 对照 parity-checklist 检查
  → 输出修复意见

阶段 5：Fix & Reconcile（Codex → Claude）
  → Codex 按 review 修复
  → Claude 处理 delta.md
  → 更新 PROGRESS.md
  → 进入下一个 feature
```

### 3.4 每日节奏（采用 GPT 建议）

```
早上：Claude 拆今天 2~4 个小任务，明确验收标准
开发时：Codex 一个线程做一个 Task，独立 worktree/branch
每完成一个任务：Claude review diff，输出修复意见
修复后：Codex 按 review 意见 patch，再跑 build/test
下班前：Claude 总结今天完成内容，更新 task-board，生成明天任务
```

### 3.5 Flutter→Android 具体映射（采用 Claude 建议）

| Flutter | Android 原生 |
|---------|-------------|
| Riverpod family + autoDispose | SavedStateHandle + viewModelScope |
| Future | suspend fun |
| Stream | Flow |
| StreamController | MutableSharedFlow / MutableStateFlow |
| GoRouter deeplink/redirect | Navigation Compose |
| shared_preferences | DataStore |
| dio | Retrofit / Ktor |
| flutter_secure_storage | EncryptedSharedPreferences |
| ThemeData | MaterialTheme + 自定义 token |

### 3.6 质量验收清单（采用 GPT 建议 + Claude 补充）

每个任务完成后必须检查：

**UI 一致性**

- [ ] 字体、颜色、间距、圆角一致
- [ ] loading / empty / error / success 状态一致
- [ ] 暗色模式表现一致

**交互一致性**

- [ ] 点击、跳转、返回行为一致
- [ ] 下拉刷新、分页加载一致
- [ ] 弹窗 / Toast / Dialog 一致
- [ ] 防重复点击一致

**业务一致性**

- [ ] API 参数、字段映射一致
- [ ] 排序、过滤、默认值一致
- [ ] 异常处理、登录态一致

**工程质量**

- [ ] 没有无关修改
- [ ] 没有重复造轮子
- [ ] 没有把业务逻辑塞进 View
- [ ] build 通过，关键测试通过


══════════════════════════════════════════════
  四、一句话总结
══════════════════════════════════════════════

```
Claude 负责"想清楚" → Codex 负责"写出来"
Claude 负责"挑毛病" → Codex 负责"修到过"
你负责"确认产品行为和业务边界"

铁律：任何不能写进文件的上下文都不要跨 Agent 传递
```


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

- [1] Anthropic, "Best practices for Claude Code" — https://code.claude.com/docs/en/best-practices
- [2] OpenAI, "Codex App" — https://developers.openai.com/codex/app
- [3] OpenAI, "Custom instructions with AGENTS.md" — https://developers.openai.com/codex/guides/agents-md
- [4] Anthropic, "Introducing Claude Opus 4.7" — https://www.anthropic.com/news/claude-opus-4-7
- [5] OpenAI, "Codex IDE extension" — https://developers.openai.com/codex/ide
- [6] OpenAI, "Codex CLI" — https://developers.openai.com/codex/cli
- [7] OpenAI, "Codex Best practices" — https://developers.openai.com/codex/learn/best-practices
- [8] GitHub, "obra/superpowers-marketplace" — https://github.com/obra/superpowers-marketplace
- [9] GitHub, "obra/superpowers" — https://github.com/obra/superpowers
