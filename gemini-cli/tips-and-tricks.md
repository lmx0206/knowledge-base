# Gemini CLI 技巧与最佳实践

> 来源：Gemini CLI 官方文档、社区实践
> 更新时间：2026年5月


══════════════════════════════════════════════
  常用命令
══════════════════════════════════════════════

```
会话控制：
  /new              新会话
  /clear            清屏 + 新会话
  /compact          压缩上下文
  /rewind           回退到之前的会话状态
  /stats            查看 token 使用量和统计

配置：
  /model            查看/切换模型
  /memory show      显示当前上下文
  /memory reload    重新加载 GEMINI.md
  /memory add <text> 添加到全局 GEMINI.md

扩展管理：
  /skills list      查看 Skills
  /extensions list  查看 Extensions
  /mcp              查看 MCP 服务器
  /hooks panel      查看 Hooks

帮助：
  /help             帮助
  /docs             打开文档
```


══════════════════════════════════════════════
  Google Search Grounding
══════════════════════════════════════════════

```
Gemini CLI 内置 Google 搜索：
  - 自动搜索最新信息
  - 基于实时数据回答
  - 不依赖训练数据截止日期

使用场景：
  - 查询最新的库版本
  - 搜索 API 文档
  - 查找解决方案
  - 验证技术信息
```

```bash
# 示例
> What is the latest version of Jetpack Compose?
# Gemini 自动搜索并返回最新信息
```


══════════════════════════════════════════════
  多模态技巧
══════════════════════════════════════════════

### 用图片生成代码

```bash
# 从设计稿生成 UI 代码
gemini
> @screenshot.png 请根据这个设计稿生成 Flutter UI 代码

# 从错误截图分析问题
> @error-screenshot.png 这个错误是什么原因？怎么修复？
```

### 从 PDF 提取信息

```bash
> @api-doc.pdf 请根据这个 API 文档生成 Retrofit 接口
```


══════════════════════════════════════════════
  会话检查点与回退
══════════════════════════════════════════════

```
Gemini CLI 自动保存会话快照：
  - 每个重要操作都会创建检查点
  - 可以用 /rewind 回退到之前的状态
  - 复杂任务的安全网

使用场景：
  - Agent 做错了，想回退
  - 想尝试不同的方案
  - 探索性开发
```

```bash
# 回退
/rewind
# 选择要回退到的检查点
```


══════════════════════════════════════════════
  Plan 模式
══════════════════════════════════════════════

```
安全的只读模式（实验性）：
  - 只分析和规划，不执行修改
  - 适合复杂任务的预规划
  - 确认后再执行

使用场景：
  - 大型重构前的规划
  - 不确定的修改
  - 代码审查
```


══════════════════════════════════════════════
  Hooks 系统
══════════════════════════════════════════════

Gemini CLI 支持 11 种 Hook 事件：

```
事件                  触发时机                    可阻止？
───────────────────── ─────────────────────────── ────────
SessionStart          会话开始时                  否
SessionEnd            会话结束时                  否
BeforeAgent           用户提交后，规划前          是
AfterAgent            Agent 循环结束时            是
BeforeModel           发送请求到 LLM 前          是
AfterModel            收到 LLM 响应后            是
BeforeToolSelection   LLM 选择工具前              是（过滤）
BeforeTool            工具执行前                  是
AfterTool             工具执行后                  是
PreCompress           上下文压缩前                否
Notification          系统通知时                  否
```

### 配置示例

```json
// .gemini/settings.json
{
  "hooks": {
    "AfterTool": [
      {
        "matcher": "write_file|replace",
        "hooks": [
          {
            "name": "lint-check",
            "type": "command",
            "command": "dart analyze --no-fatal-infos",
            "timeout": 10000
          }
        ]
      }
    ]
  }
}
```

### 与 Claude Code Hooks 对比

```
┌─────────────────┬──────────────┬──────────────┐
│ 特性             │ Gemini CLI   │ Claude Code  │
├─────────────────┼──────────────┼──────────────┤
│ 事件数量        │ 11 种        │ 12 种        │
│ 通配符匹配      │ ✅           │ ✅           │
│ 正则匹配        │ ✅ 工具事件  │ ✅           │
│ 项目级 Hooks    │ ✅ 指纹验证  │ ✅           │
│ 环境变量        │ ✅ GEMINI_*  │ ✅ CLAUDE_*  │
│ JSON 通信       │ ✅           │ ✅           │
│ 退出码控制      │ 0/2/其他     │ 0/2/其他     │
└─────────────────┴──────────────┴──────────────┘
```


══════════════════════════════════════════════
  GitHub 集成
══════════════════════════════════════════════

### Gemini CLI GitHub Action

```yaml
# .github/workflows/gemini-review.yml
name: AI Code Review
on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: google-github-actions/run-gemini-cli@v1
        with:
          prompt: "Review this PR and provide feedback"
        env:
          GEMINI_API_KEY: ${{ secrets.GEMINI_API_KEY }}
```

### 在 Issues/PRs 中使用

```
在 GitHub Issues 或 PRs 中 @gemini-cli：
  @gemini-cli 请分析这个 bug 的根因
  @gemini-cli 请审查这段代码
  @gemini-cli 请为这个 feature 写实现方案
```


══════════════════════════════════════════════
  沙箱使用
══════════════════════════════════════════════

```
Gemini CLI 内置沙箱：
  - 隔离工具执行
  - 防止意外修改系统文件
  - 可配置信任级别

MCP 服务器的信任设置：
  trust: true — 跳过确认
  trust: false — 每次确认（默认）
```


══════════════════════════════════════════════
  自定义命令
══════════════════════════════════════════════

```
Gemini CLI 支持自定义命令：
  - 在 .gemini/commands/ 目录中创建
  - 可以封装常用操作
  - 团队共享
```


══════════════════════════════════════════════
  Model Routing（模型路由）
══════════════════════════════════════════════

```
Gemini CLI 支持自动模型回退：
  - 主模型不可用时自动切换
  - 保证任务连续性
  - 无需手动干预
```


══════════════════════════════════════════════
  最佳实践
══════════════════════════════════════════════

```
1. 使用 Google 账号登录（免费额度最大方）
2. 写好 GEMINI.md（50-200 行）
3. 使用 @file 导入拆分大文件
4. 使用 .geminiignore 排除无关文件
5. 用 Skills 替代重复说明
6. 利用 Google Search 查询最新信息
7. 用 /rewind 做安全回退
8. 用 Plan 模式做复杂任务预规划
9. 配置 Hooks 实现自动化验证
10. 用 GitHub Action 集成到 CI/CD
```


══════════════════════════════════════════════
  常见问题排查
══════════════════════════════════════════════

```
Q: Gemini CLI 启动后卡住
A: 检查网络连接和认证状态
   尝试 gemini --headless "test" 看是否有错误

Q: 免费额度用完了
A: 等待明天重置（1000 次/天）
   或使用 API Key（另外 1000 次/天）

Q: MCP 服务器连接失败
A: 检查 settings.json 中的配置
   确认 MCP 服务器已安装
   检查 timeout 设置

Q: Skills 没有被发现
A: 确认 SKILL.md 文件名正确
   检查目录位置（~/.gemini/skills/ 或 .gemini/skills/）
   使用 /skills reload 刷新

Q: Hooks 不执行
A: 检查 JSON 格式是否正确
   确认 matcher 匹配
   查看 stderr 日志
```


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Gemini CLI 官方文档
    https://geminicli.com/docs/

[2] Gemini CLI GitHub 仓库
    https://github.com/google-gemini/gemini-cli

[3] Gemini CLI Hooks 文档
    https://geminicli.com/docs/hooks

[4] Gemini CLI GitHub Action
    https://github.com/google-github-actions/run-gemini-cli

[5] Gemini CLI Extensions
    https://geminicli.com/docs/extensions
