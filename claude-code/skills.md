# Claude Code 技能系统（Skills）

> 来源：Anthropic 官方文档，obra/superpowers，社区实践

## 什么是 Skills？

Skills 是 Claude Code 的可复用工作流程系统。
一个 Skill 就是一个 SKILL.md 文件，包含特定任务的详细指令。

```
Skill = 任务的"菜谱"
  告诉 Claude：
  - 什么时候触发
  - 按什么步骤做
  - 注意什么陷阱
  - 怎么验证结果
```

## Skills vs CLAUDE.md

```
CLAUDE.md：
  - 项目级别的规则和背景
  - 每次会话都加载
  - 类似"公司规章制度"

Skills：
  - 任务级别的详细步骤
  - 按需加载
  - 类似"操作手册"
```

## 安装 Skills

### 方法 1：使用 /skill 命令

```bash
# 在 Claude Code 会话中
/skill superpowers        # 加载 Superpowers
/skill test-driven-development  # 加载 TDD 技能
```

### 方法 2：通过插件市场

```bash
# 安装 Superpowers（包含多个 Skills）
/plugin install superpowers@claude-plugins-official
```

### 方法 3：手动创建

在项目的 `.claude/skills/` 目录中创建 SKILL.md 文件。

> 来源：Anthropic 官方文档


══════════════════════════════════════════════
  Skills 的结构
══════════════════════════════════════════════

```markdown
# SKILL.md 示例

## 触发条件
当用户要求创建新的 Flutter feature 时触发。

## 步骤
1. 在 lib/features/ 下创建目录结构
2. 创建 data/domain/presentation 三层
3. 编写 Repository 接口和实现
4. 编写 UseCase
5. 编写 ViewModel
6. 编写 UI（Screen + Widget）
7. 编写测试

## 约束
- domain 层不依赖外部包
- 使用 Riverpod 管理状态
- 每层都有测试

## 验证
- flutter test 全部通过
- dart analyze 零警告
```

## 最佳实践

```
1. 保持 SKILL.md 在 500 行以内
   超过时拆分为多个文件

2. 明确触发条件
   告诉 Claude 什么时候用这个技能

3. 写清步骤，不要假设上下文
   子代理每次都是全新上下文

4. 包含验证步骤
   怎么确认任务完成了

5. 写明"为什么"
   Claude 理解原理后执行更好
```

> 来源：Anthropic 官方文档 — Skill authoring best practices


══════════════════════════════════════════════
  推荐安装的 Skills
══════════════════════════════════════════════

### 1. Superpowers（强烈推荐）

包含 TDD、调试、计划、代码审查等完整工作流。

```bash
/plugin install superpowers@claude-plugins-official
```

### 2. Firecrawl Skills

网页抓取和数据提取。

### 3. 自定义 Skills

根据你的项目需求创建：
- Flutter feature 创建流程
- Android ViewModel 模板
- API 集成流程
- 发布流程

> 来源：Firecrawl Blog, "Best Claude Code Skills to Try in 2026"


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Anthropic 官方文档 — Agent Skills
    https://platform.claude.com/docs/en/agents-and-tools/agent-skills

[2] Anthropic 官方文档 — Skill authoring best practices
    https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices

[3] Firecrawl Blog, "Best Claude Code Skills to Try in 2026"
    https://www.firecrawl.dev/blog/best-claude-code-skills

[4] obra/superpowers — Skills Library
    https://github.com/obra/superpowers/tree/main/skills
