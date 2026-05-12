# Claude 回答：Claude Code + Codex Desktop + Superpowers 多 Agent 协作工作流

> 提问者：mason
> 来源：Claude (Opus 4.7)
> 时间：2026年5月

## 核心思路

让"仓库本身"成为共享内存。两个 Agent 不共享会话上下文，正确做法是把所有上下文都落盘到 Git 仓库，
让仓库成为唯一事实源（single source of truth）。Superpowers 的设计本来就是这个思路。

## 1. 落盘到仓库的内容

- `CLAUDE.md` 和 `AGENTS.md`：项目级 system prompt，内容完全一致，建议 symlink
- `docs/migration/`：迁移总体架构、Flutter↔Android 映射表、ADR
- `plans/`：Superpowers 生成的实施计划
- `specs/`：每个 feature 的需求规格（brainstorm 产物）
- `PROGRESS.md`：当前进度

## 2. 一次性设置

### 安装 Superpowers（两边都装）

Claude Code:

```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

Codex App：侧边栏 Plugins → Coding 区找 Superpowers → 点 +

### Symlink system prompt

`ln -s CLAUDE.md AGENTS.md` — 两边永远读同一份字节

### CLAUDE.md / AGENTS.md 核心内容

- Target stack：Kotlin 2.x, Jetpack Compose, Material 3, Hilt, Room, Retrofit, ViewModel + StateFlow
- Migration principles：一次迁移一个 feature, 严格 TDD, 行为对等优先于代码相似
- Commands：./gradlew assembleDebug, test, connectedCheck, ktlintCheck detekt
- Quality gates：All tests green, ktlint + detekt clean, 关键路径有 Compose UI 测试
- Agent role split：规划由 Claude Code 完成，执行由 Codex 完成
- Delta 文件机制：执行中发现 plan 有误 → 停 → 写 delta → 等 planner 处理

## 3. 四阶段循环（每个 feature）

### 阶段 1 — Brainstorm（Claude Code Opus 4.7）

使用 /superpowers:brainstorm

- 读 flutter_src/ 全部代码、mapping.md、CLAUDE.md
- 苏格拉底式提问，固化行为规格到 specs/<feature>.md
- 不写代码

### 阶段 2 — Write Plan（Claude Code Opus 4.7）

使用 /superpowers:write-plan

- 输出到 plans/<feature>.md
- 每个 task 2-5 分钟可完成
- TDD 顺序：先 ViewModel 单测 → Compose UI 测试 → 实现
- 每 3-5 个 task 设一个 git commit 检查点
- 人工 review plan — 错误在便宜的时候发现

### 阶段 3 — Execute（Codex）

使用 /superpowers:execute-plan

- 严格按 plan 顺序，不跳步
- TDD red/green/refactor 必须真正执行
- 每个 task 完成后跑 ./gradlew test ktlintCheck
- 如果发现 plan 有误 → 停 → 写 delta.md → 等指示
- 用 git worktree 隔离工作

### 阶段 4 — Reconcile（回到 Claude Code）

- 处理 delta.md
- 更新 plan 或 spec
- 更新 PROGRESS.md
- 进入下一个 feature

## 4. 上下文同步技巧

1. Symlink 两份 system prompt
2. 用 Git 当心跳：每个 task 一个小 commit，commit message 带 plan task ID
3. Delta 文件机制：永远不让执行 Agent 偷偷偏离 plan
4. 保留 transcript：每个 feature 结束后导出存到 docs/sessions/
5. Context7 MCP 插件：避免引用过期 API

## 5. Flutter→Android 迁移常见坑

- Riverpod family + autoDispose → SavedStateHandle + viewModelScope
- Future → suspend fun, Stream → Flow, StreamController → MutableSharedFlow/MutableStateFlow
- GoRouter deeplink/redirect → Navigation Compose 单独处理
- shared_preferences → DataStore, dio → Retrofit/Ktor, flutter_secure_storage → EncryptedSharedPreferences
- ThemeData → MaterialTheme + 自定义 token，独立做一遍

## 6. 铁律

"任何不能写进文件的上下文都不要跨 Agent 传递"
不要让任何一个 Agent 独自从头干到尾

## 参考来源

- [1] https://code.claude.com/docs/en/best-practices
- [2] https://developers.openai.com/codex/app
- [3] https://developers.openai.com/codex/guides/agents-md
- [4] https://www.anthropic.com/news/claude-opus-4-7
- [5] https://developers.openai.com/codex/learn/best-practices
- [6] https://github.com/obra/superpowers
- [7] https://github.com/obra/superpowers-marketplace
