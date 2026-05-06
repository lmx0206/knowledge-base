# Codex 技能系统（Skills）

> 来源：OpenAI 官方文档、obra/superpowers、社区实践

## 什么是 Skills？

Skills 是 Codex CLI 的可复用工作流程系统。
一个 Skill 就是一个 SKILL.md 文件，包含特定任务的详细指令。

```
Skill = 任务的"菜谱"
  告诉 Codex：
  - 什么时候触发
  - 按什么步骤做
  - 注意什么陷阱
  - 怎么验证结果
```

## Skills vs AGENTS.md

```
AGENTS.md：
  - 项目级别的规则和背景
  - 每次会话都加载
  - 类似"公司规章制度"

Skills：
  - 任务级别的详细步骤
  - 按需加载
  - 类似"操作手册"
```


══════════════════════════════════════════════
  Superpowers 集成
══════════════════════════════════════════════

Superpowers 是最推荐安装的 Skills 框架（176K+ stars），
包含 TDD、调试、计划、代码审查等完整工作流。

### 在 Codex CLI 中安装

```bash
# 打开插件搜索界面
/plugins
# 搜索并安装
superpowers
```

### 在 Codex App 中安装

```
1. 在 Codex 应用中点击侧边栏的 "Plugins"
2. 在 Coding 分类中找到 Superpowers
3. 点击 + 号安装
```

### Superpowers 包含的 Skills

```
测试类：
  test-driven-development — RED-GREEN-REFACTOR 循环

调试类：
  systematic-debugging — 4 阶段根因分析
  verification-before-completion — 确认问题真的修复了

协作类：
  brainstorming — 苏格拉底式设计精炼
  writing-plans — 详细实施计划
  executing-plans — 批量执行 + 人工检查点
  subagent-driven-development — 快速迭代 + 两阶段审查
  requesting-code-review — 提交前检查清单

元技能：
  writing-skills — 创建新技能的最佳实践
  using-superpowers — 技能系统介绍
```

### 安装后验证

```
1. 开始新的 Codex 会话
2. 说 "帮我做个登录功能"
3. 如果安装成功，Agent 会：
   - 宣布它正在使用哪个技能
   - 先问问题而不是直接写代码
   - 遵循结构化流程
```

> 来源：GitHub obra/superpowers README


══════════════════════════════════════════════
  自定义 Skills
══════════════════════════════════════════════

### Skills 结构

```markdown
# SKILL.md 示例

## 触发条件
当用户要求创建新的 Android feature 时触发。

## 步骤
1. 分析需求，确认架构
2. 在 features/ 下创建目录结构
3. 创建 data/domain/presentation 三层
4. 编写 Repository 接口和实现
5. 编写 UseCase
6. 编写 ViewModel
7. 编写 UI（Screen + Widget）
8. 编写测试

## 约束
- domain 层不依赖外部包
- 使用 Hilt 注入依赖
- 每层都有测试

## 验证
- ./gradlew test 全部通过
- ./gradlew lint 零警告
```

### 推荐积累的 Skills

```
android-项目初始化    — 新建 Android 项目的标准流程
flutter-项目初始化    — 新建 Flutter 项目的标准流程
compose-ui审查       — Jetpack Compose UI 代码审查清单
gradle-依赖更新       — 安全更新 Gradle 依赖的流程
app-发布流程         — 发布到 Play Store 的完整步骤
api-集成流程         — 集成新 API 的标准流程
```

### 最佳实践

```
1. 保持 SKILL.md 在 500 行以内
2. 明确触发条件
3. 写清步骤，不要假设上下文
4. 包含验证步骤
5. 写明"为什么"（理解原理后执行更好）
```

> 来源：Anthropic 官方文档 — Skill authoring best practices


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] obra/superpowers GitHub 仓库
    https://github.com/obra/superpowers

[2] OpenAI Codex 官方文档
    https://developers.openai.com/codex

[3] Anthropic — Skill authoring best practices
    https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices

[4] Termdock — Superpowers: Skills Framework Reshaping AI Dev
    https://www.termdock.com/en/blog/superpowers-framework-agent-skills
