# 大型 Android 项目的 Agent Harness 搭建指南

> 目标：让 AI Agent 能在大型多模块 Android 项目中可靠地读代码、改代码、跑验证、收敛到可合并结果。
> 核心原则：不要让 Agent 一次性读取每行代码，而是让仓库本身变成可导航、可验证、可约束的工作环境。

## 核心判断

大型 Android 项目里，Agent 的瓶颈通常不是“模型不知道 Kotlin”，而是：

- 仓库没有清晰的模块地图
- 架构规则只存在于人脑或聊天记录里
- 工具类和公共抽象没有索引
- 编码规范不可执行，只靠口头提醒
- 验证命令分散，Agent 不知道改动后该跑什么
- 失败日志、lint、测试结果没有进入反馈循环

OpenAI 在 Codex 的 Harness Engineering 实验里也强调：团队主要工作从“手写代码”变成“设计环境、指定意图、构建反馈循环”。他们在约五个月内从空仓库构建出约一百万行代码，期间约 1,500 个 PR，由早期 3 名工程师驱动，之后团队增长到 7 人；关键不是一次性把所有代码塞进上下文，而是把仓库知识、工具、验证、日志和 review loop 都变成 Agent 可直接使用的系统。

## 一、不要追求“读完每行代码”

“让 Agent 读取每行代码”听起来合理，但在大型多模块项目中不可持续：

- 上下文窗口有限，完整源码会挤掉任务、错误日志和相关文档
- 代码量越大，越容易出现 lost in the middle
- 旧代码、生成代码、第三方代码会稀释真正相关的上下文
- Agent 需要的是当前任务的相关切片，不是全量源码快照

更好的目标是：让 Agent 能快速定位“应该读哪几行代码”。

实践方式：

```text
AGENTS.md                         # 入口地图，不写百科全书
ARCHITECTURE.md                   # 架构总览
docs/android/module-map.md        # 模块职责和依赖方向
docs/android/utility-index.md     # 工具类和公共抽象索引
docs/android/coding-style.md      # 编码规范和可执行检查
docs/android/testing-guide.md     # 按改动类型选择验证命令
docs/android/change-checklist.md  # 改动前后检查清单
docs/generated/gradle-projects.md # 自动生成的 Gradle 模块列表
docs/generated/dependency-graph.md # 自动生成的模块依赖图
```

`AGENTS.md` 应该像目录，不应该像 1,000 页手册。OpenAI 的经验是：短入口文档 + repo 内结构化知识库，比一个巨大的 `AGENTS.md` 更适合 Agent 使用。

## 二、Android 多模块项目的模块地图

Android 多模块项目需要把“模块职责”显式写出来。Gradle 官方文档说明，multi-project build 适合把增长中的项目拆成更小、更聚焦、能一起构建和测试的 subprojects。

示例：

```markdown
# Module Map

## :app
应用入口、导航、DI wiring、进程级初始化。
禁止承载业务逻辑。

## :feature:login
登录 UI、ViewModel、登录流程编排。
只能依赖 :domain:user、:core:ui、:core:common。

## :domain:user
用户相关 domain model、repository interface、use case。
禁止依赖 Android framework、Retrofit、Room、Compose。

## :data:user
UserRepository 实现、remote/local data source、DTO/entity mapper。
可以依赖 :domain:user、:core:network、:core:database。

## :core:network
Retrofit、OkHttp、认证拦截器、API error parser。

## :core:database
Room database、DAO、migration。

## :core:ui
Design system、Compose component、theme、icon、spacing。

## :core:common
纯 Kotlin 公共能力：Result、Clock、Dispatcher、Logger interface。
```

这个文件解决的是 Agent 的第一个问题：新代码应该放在哪里。

## 三、架构规则：用机器执行，而不是靠提示词提醒

Android 官方架构指南强调 separation of concerns、UI layer、data layer、可选 domain layer、single source of truth 和 unidirectional data flow。对 Agent 来说，这些原则必须落成机械规则。

推荐约束：

```text
:domain:* 不依赖 Android framework
:domain:* 不依赖 :data:* 或 :feature:*
:feature:* 不直接依赖 :data:* 的 DataSource
:feature:* 通过 use case 或 repository interface 获取业务数据
:app 只做 wiring，不写业务规则
:core:ui 不依赖业务 feature
:core:common 不依赖 Android、Compose、Retrofit、Room
```

可执行方式：

- Gradle dependency constraints：限制 module 依赖方向
- Detekt custom rules：检查禁止 API、命名、复杂度
- Android Lint：检查 Android API、资源、性能和兼容性问题
- Konsist / ArchUnitKotlin：写架构测试，验证 package/class/module 边界
- CI：所有规则在 PR 上自动执行

给 Agent 的指令应该是：

```markdown
如果架构测试失败，优先修正依赖方向，不要通过放宽规则解决。
如果必须修改规则，需要先更新 ARCHITECTURE.md 并说明原因。
```

## 四、编码规范：从文档变成命令

编码规范建议采用官方 Kotlin / Android Kotlin Style 作为基线：

- UTF-8
- 4 spaces indentation
- 禁止 wildcard imports
- 每行建议不超过 100 字符
- 一个文件围绕单一主题
- Kotlin source file 命名与主要类型一致
- public declaration 最小化

推荐工具链：

```text
Spotless 或 ktlint       格式化
Detekt                  Kotlin 静态分析
Android Lint            Android 专项检查
Gradle check            汇总 verification lifecycle
Konsist/ArchUnitKotlin  架构边界测试
```

推荐统一命令：

```bash
./gradlew spotlessCheck
./gradlew detekt
./gradlew lintDebug
./gradlew testDebugUnitTest
./gradlew :app:assembleDebug
```

在 `AGENTS.md` 中不要只写“保持代码整洁”，而要写：

```markdown
完成 Android 代码修改前必须运行：

1. `./gradlew spotlessCheck`
2. `./gradlew detekt`
3. `./gradlew lintDebug`
4. `./gradlew testDebugUnitTest`
5. 涉及 app wiring 或 manifest 时运行 `./gradlew :app:assembleDebug`

任何命令失败都必须先修复，再声明完成。
```

## 五、工具类使用：建立 Utility Index

Agent 很容易重复造工具类。解决方式不是反复说“请复用”，而是维护 `docs/android/utility-index.md`。

示例：

```markdown
# Utility Index

## 时间
使用 `ClockProvider`。
禁止直接调用 `System.currentTimeMillis()`，除非在 `ClockProvider` 实现内部。

## Coroutine dispatcher
使用 `AppDispatchers`。
ViewModel、Repository、UseCase 中禁止硬编码 `Dispatchers.IO`。

## Result
使用 `AppResult<T>`。
禁止新增 `Either`、`Resource`、`ResultWrapper` 等平行抽象。

## Logging
使用 `AppLogger`。
禁止直接调用 `Log.d` / `Log.e`。

## JSON
使用项目统一的 Moshi 或 Kotlinx Serialization 配置。
禁止局部新建 parser。

## Date/Time
优先使用 `java.time`。
禁止新增 `SimpleDateFormat`，除非是 legacy 互操作并带测试。
```

更好的做法：把关键条目升级成 Detekt / Lint 规则。

```text
文档负责告诉 Agent 去哪里找
Lint 负责阻止 Agent 绕过去
测试负责证明 Agent 改对了
```

## 六、按改动类型选择上下文

Agent 每次任务都应该先做“上下文路由”。

示例：

```markdown
# Change Context Routing

## 修改 Compose UI
先读：
- docs/android/module-map.md
- docs/android/design-system.md
- :core:ui 相关 component
- 目标 feature 的 screen / ViewModel / ui state

验证：
- `./gradlew :feature:<name>:testDebugUnitTest`
- `./gradlew :feature:<name>:lintDebug`
- 如有 screenshot test，运行对应任务

## 修改 Repository
先读：
- docs/android/module-map.md
- docs/android/utility-index.md
- domain repository interface
- data repository implementation
- remote/local data source
- mapper

验证：
- repository unit test
- mapper test
- fake API / database test

## 修改 Gradle 依赖
先读：
- settings.gradle(.kts)
- libs.versions.toml
- 受影响 module 的 build.gradle(.kts)
- docs/android/dependency-rules.md

验证：
- `./gradlew projects`
- `./gradlew :app:assembleDebug`
- `./gradlew testDebugUnitTest`
```

这能减少 Agent 盲目搜索，也能减少读错上下文。

## 七、Harness 的五个子系统

面向大型 Android 项目，可以把 Harness 拆成五个子系统。

| 子系统 | 解决的问题 | 关键文件 / 工具 |
|--------|------------|-----------------|
| Context System | Agent 应该读什么 | `AGENTS.md`、`ARCHITECTURE.md`、module map、utility index |
| Execution System | Agent 如何运行项目 | Gradle wrapper、Android SDK、emulator、mock server |
| Verification System | 怎么证明改对了 | unit test、lint、detekt、assemble、screenshot test |
| Constraint System | 怎么防止架构腐化 | dependency rules、architecture tests、custom lint |
| Feedback System | 怎么持续变好 | PR review、CI 日志、失败归因、changelog、tech debt tracker |

最小可行目录：

```text
AGENTS.md
ARCHITECTURE.md
docs/android/module-map.md
docs/android/coding-style.md
docs/android/utility-index.md
docs/android/testing-guide.md
docs/android/change-checklist.md
scripts/agent-context.sh
scripts/verify-android.sh
```

`scripts/verify-android.sh` 示例：

```bash
#!/usr/bin/env bash
set -euo pipefail

./gradlew spotlessCheck
./gradlew detekt
./gradlew lintDebug
./gradlew testDebugUnitTest
./gradlew :app:assembleDebug
```

## 八、AGENTS.md 模板

```markdown
# AGENTS.md — Android 多模块项目

## 开始工作前
1. 阅读 `ARCHITECTURE.md`
2. 阅读 `docs/android/module-map.md`
3. 阅读 `docs/android/utility-index.md`
4. 用 `rg` 搜索现有实现，优先复用项目内模式
5. 检查 `git status --short`，不要覆盖用户未提交改动

## 硬约束
1. `:domain:*` 不依赖 Android framework、Compose、Retrofit、Room
2. `:app` 只负责入口、导航、DI wiring，不写业务逻辑
3. ViewModel 不直接访问 DataSource
4. Compose 不包含业务规则
5. 公共能力优先查 `docs/android/utility-index.md`
6. 不新增平行 Result / Logger / Dispatcher / Clock 抽象
7. 架构测试失败时修代码，不放宽规则

## 验证
完成前至少运行：
- `./gradlew spotlessCheck`
- `./gradlew detekt`
- `./gradlew lintDebug`
- `./gradlew testDebugUnitTest`

涉及 app wiring、manifest、DI、navigation 时追加：
- `./gradlew :app:assembleDebug`

## 更新文档
如果新增 module、公共工具、架构规则或验证命令，必须同步更新 `docs/android/`。
```

## 九、从现有项目开始的落地顺序

1. 生成模块清单：`./gradlew projects`
2. 写 `docs/android/module-map.md`
3. 梳理 `core` / `common` / `utils`，写 `utility-index.md`
4. 写 `testing-guide.md`，按改动类型列出验证命令
5. 把 Kotlin style、Detekt、Android Lint 接入统一验证脚本
6. 增加架构测试，先覆盖最关键的依赖方向
7. 把常见 review comment 转成 lint、测试或文档规则
8. 每次 Agent 犯同类错误时，优先修 Harness，而不是只修当次代码

## 十、判断 Harness 是否有效

有效的 Android Agent Harness 应该带来这些结果：

- Agent 能在 3-5 分钟内说明相关 module 和验证命令
- 新增功能时不会把业务逻辑塞进 `:app`
- 不会重复创建 Result、Logger、Dispatcher 等基础抽象
- CI 失败信息足够清楚，Agent 能根据错误自行修复
- 架构约束由测试或 lint 强制，而不是靠人工反复提醒
- 新会话不依赖聊天历史，也能从 repo 文件恢复上下文

最终目标不是让 Agent “记住一切”，而是让项目“可被 Agent 重新发现”。

## 参考来源

- [OpenAI - Harness engineering: leveraging Codex in an agent-first world](https://openai.com/index/harness-engineering/)
- [Android Developers - Guide to app architecture](https://developer.android.com/topic/architecture)
- [Android Developers - Kotlin style guide](https://developer.android.com/kotlin/style-guide)
- [Kotlin Documentation - Coding conventions](https://kotlinlang.org/docs/coding-conventions.html)
- [Gradle Documentation - Multi-Project Builds](https://docs.gradle.org/current/userguide/multi_project_builds.html)
