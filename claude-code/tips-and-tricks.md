# Claude Code 技巧与最佳实践

> 来源：多个社区文章和官方文档
> 更新时间：2026年5月

## 日常使用技巧

### 1. 使用 /init 生成 CLAUDE.md

```bash
# 在项目根目录运行
/init

# Claude 会扫描代码库，生成定制的 CLAUDE.md
# 然后你可以手动编辑优化
```

### 2. 使用 Plan Mode 处理复杂任务

```bash
/plan
# 或 Shift + Tab

# Claude 会：
# 1. 收集上下文
# 2. 问澄清问题
# 3. 制定计划
# 4. 确认后再实现
```

### 3. 使用 @ 引用文件

```bash
# 在对话中引用特定文件
@src/features/auth/login.dart 这个文件有什么问题？

# 引用多个文件
@src/models/user.dart @src/repo/user_repo.dart 帮我重构
```

### 4. 使用 /compact 定期压缩

```bash
# 每 10-15 轮对话运行一次
/compact

# 或者在切换任务时
```

### 5. 使用子代理处理独立任务

```bash
# 让 Claude 派遣子代理
帮我并行处理这三个文件的重构

# 子代理有独立上下文，不污染主会话
```


══════════════════════════════════════════════
  工作流最佳实践
══════════════════════════════════════════════

### TDD 工作流（配合 Superpowers）

```
1. "帮我写这个功能的测试"
2. 确认测试失败（RED）
3. "现在实现这个功能"
4. 确认测试通过（GREEN）
5. "重构这段代码"
6. 确认测试仍然通过（REFACTOR）
```

### 代码审查工作流

```
1. "审查 @src/features/auth/ 目录的代码"
2. Claude 按严重程度报告问题
3. "修复所有 Critical 问题"
4. "现在处理 Warning 级别问题"
```

### 调试工作流

```
1. 贴上错误信息
2. "帮我分析这个错误的根本原因"
3. Claude 先诊断，再给方案
4. "按方案 A 修复"
5. "写测试防止这个问题再次发生"
```


══════════════════════════════════════════════
  常见问题
══════════════════════════════════════════════

Q: Claude 忘记了之前的讨论？
A: 运行 /compact 压缩上下文，或 /clear 开始新会话。

Q: Claude 生成的代码有错误？
A: 让它运行测试验证："运行 flutter test 确认"。

Q: Claude 读取了太多文件？
A: 明确指定文件："只看 @src/features/auth/"。

Q: 会话太长，token 消耗太多？
A: 完成一个任务就 /clear，开始新任务。

Q: Claude 不遵循我的规则？
A: 检查 CLAUDE.md 是否太长（>200行），
   关键规则是否放在了顶部。

Q: 如何让 Claude 更快？
A: 使用 /compact，精简 CLAUDE.md，
   精确指定文件范围。


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Anthropic 官方文档 — Claude Code Best Practices
    https://www.anthropic.com/engineering/claude-code-best-practices

[2] Builder.io, "50 Claude Code Tips and Best Practices"
    https://www.builder.io/blog/claude-code-tips-best-practices

[3] CreatorEconomy, "20 Tips to Master Claude Code in 35 Minutes"
    https://creatoreconomy.so/p/20-tips-to-master-claude-code-in-35-min-build-an-app

[4] LevelUp, "Claude Code Mastery: The 21 Tips That Actually Matter"
    https://levelup.gitconnected.com/claude-code-mastery-the-21-tips-that-actually-matter-in-2026-5436f50ddbed

[5] My Android Solutions, "Claude Code for Android Development"
    https://www.myandroidsolutions.com/2026/02/28/claude-code-android-development-best-practices/
