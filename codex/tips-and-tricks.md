# Codex 技巧与最佳实践

> 来源：OpenAI 官方文档、社区实践
> 更新时间：2026年5月


══════════════════════════════════════════════
  TUI 快捷键与导航
══════════════════════════════════════════════

```
基本操作：
  Enter        发送消息
  Ctrl+C       中断当前操作
  Ctrl+D       退出
  ↑/↓          浏览历史消息

会话管理：
  /new         新会话
  /clear       清屏
  /compact     压缩上下文
  /cost        查看 token 使用量
  /help        帮助

配置：
  /model       查看/切换模型
  /config      查看配置
```


══════════════════════════════════════════════
  codex exec 脚本化
══════════════════════════════════════════════

### 基本用法

```bash
# 直接执行
codex exec "describe the architecture of this project"

# 从 stdin 读取
cat error.log | codex exec "Analyze this error log and suggest fixes"

# 组合使用
echo "my output" | codex exec "Summarize this concisely"
```

### CI/CD 集成

```yaml
# GitHub Actions
- name: AI Review
  run: |
    codex exec --ephemeral \
      --sandbox read-only \
      "Review the changes in this PR"
  env:
    OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
```

### 批量处理

```bash
# 批量审查多个文件
for file in src/*.py; do
  codex exec --ephemeral "Review $file for bugs"
done
```


══════════════════════════════════════════════
  沙箱使用技巧
══════════════════════════════════════════════

### 选择合适的沙箱模式

```
代码审查        → read-only
日常开发        → workspace-write
自动化任务      → read-only + exec
容器环境        → danger-full-access
```

### 测试沙箱行为

```bash
# 测试命令是否被允许
codex sandbox linux "ls -la"
codex sandbox linux "rm -rf /"
codex sandbox macos --log-denials "curl http://evil.com"
```

### 持久化沙箱配置

```toml
# ~/.codex/config.toml
sandbox_mode = "workspace-write"
```


══════════════════════════════════════════════
  日志与调试
══════════════════════════════════════════════

### 日志位置

```bash
# TUI 日志
tail -F ~/.codex/log/codex-tui.log

# 自定义日志目录
codex -c log_dir=./.codex-log
```

### 设置日志级别

```bash
# 详细日志
RUST_LOG=debug codex

# 仅错误
RUST_LOG=error codex exec "task"

# 默认级别
RUST_LOG=codex_core=info,codex_tui=info codex
```

### 配置日志级别

```bash
# TUI 默认：codex_core=info,codex_tui=info
# exec 默认：error
# 可通过 RUST_LOG 环境变量覆盖
```


══════════════════════════════════════════════
  AGENTS.md 最佳实践（Codex 专用）
══════════════════════════════════════════════

```markdown
# AGENTS.md — Codex 优化版

## 项目概述
[一句话描述]

## 技术栈
[核心技术列表]

## 开始工作前
1. 运行 ./gradlew assembleDebug 确保编译通过
2. 运行 ./gradlew test 确保测试通过
3. 阅读 progress.md 了解上次进度

## 硬约束（最多 10 条）
1. Kotlin only
2. StateFlow not LiveData
3. Material 3
4. 每个 ViewModel 有测试
5. lint 零警告才能提交

## 常用命令
- 构建：./gradlew assembleDebug
- 测试：./gradlew test
- lint：./gradlew lint
```

### 关键原则

```
1. 保持简短（50-200 行）
2. 关键规则放顶部
3. 不要写 Codex 能自己查到的信息
4. 写具体命令，不要抽象描述
5. 包含已知坑和解决方案
```


══════════════════════════════════════════════
  DotSlash：版本锁定
══════════════════════════════════════════════

Codex 支持 DotSlash，可以锁定团队使用同一版本：

```bash
# GitHub Release 中包含 .dotslash 文件
# 提交到仓库，确保所有人使用相同版本
git add codex.dotslash
git commit -m "Lock Codex version"
```


══════════════════════════════════════════════
  WSL2 专属技巧
══════════════════════════════════════════════

```
1. 自动 Toast 通知
   Codex 检测到 WT_SESSION 后自动使用 Windows 通知
   无需额外配置

2. 文件路径
   Windows 路径：D:\code\project
   WSL 路径：/mnt/d/code/project

3. 性能优化
   在 WSL 文件系统中工作（/home/user/）
   比 /mnt/c/ 或 /mnt/d/ 快很多
```


══════════════════════════════════════════════
  常见问题排查
══════════════════════════════════════════════

```
Q: Codex 启动后卡住
A: 检查网络连接和 API Key 有效性
   RUST_LOG=debug codex 查看详细日志

Q: 沙箱阻止了正常命令
A: 用 codex sandbox 测试命令
   考虑切换到 workspace-write 模式

Q: MCP 服务器连接失败
A: 检查 config.toml 中的配置
   确认 MCP 服务器已安装

Q: 通知不工作
A: macOS：确保 terminal-notifier 已安装
   WSL2：确保在 Windows Terminal 中运行
```


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] OpenAI Codex 官方文档
    https://developers.openai.com/codex

[2] Codex CLI GitHub 仓库
    https://github.com/openai/codex

[3] Codex 安装文档
    https://github.com/openai/codex/blob/main/docs/install.md

[4] DotSlash 文档
    https://dotslash-cli.com/
