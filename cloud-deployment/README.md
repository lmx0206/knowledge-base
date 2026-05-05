# 免费云服务器部署 Hermes Agent 指南

> 创建时间：2026年5月
> 验证状态：已联网核查
> 适用人群：中国大陆用户（有 VPN）

## 目录

```
cloud-deployment/
└── README.md    ← 你在这里
```


══════════════════════════════════════════════
  Google AI Pro 包含免费云服务器吗？
══════════════════════════════════════════════

**不包含云服务器，但有其他福利。**

```
Google AI Pro ($20/月) 包含：
  ✓ Gemini Advanced（高级模型访问）
  ✓ 5TB Google Cloud 存储
  ✓ 每月 $10 Google Cloud Credits（需手动领取）
  ✓ Gemini in Gmail、Docs 等
  ✗ 不包含免费云服务器/VM
```

```
Google Cloud 免费方案（与 AI Pro 独立）：
  ✓ $300 免费额度（90 天）
  ✓ Always Free 服务（有限制）
  ✓ e2-micro 实例（美国区域，永久免费）
     - 0.25 vCPU, 1GB RAM
     - 太小，不适合运行 Hermes Agent
```

结论：Google AI Pro 的 $10 月度 Credits 可以用于 Google Cloud，
但 Google Cloud 的免费 VM 配置太低，不适合运行 Agent。

> 来源：
> [1] Google AI Plans 官方页面 https://one.google.com/intl/en/about/google-ai-plans/
> [2] Reddit r/google_antigravity "FYI - Gemini AI Pro includes $10 monthly Google Cloud Credits"
> [3] Google Cloud Free Tier https://cloud.google.com/free


══════════════════════════════════════════════
  Oracle Cloud Always Free — 最佳方案
══════════════════════════════════════════════

**这是目前最适合部署 Hermes Agent 的免费方案。**

### 免费配置

```
┌─────────────────────────────────────────────────┐
│  Oracle Cloud Always Free（永久免费）             │
│                                                 │
│  ARM 实例（A1 Flex）：                           │
│    - 最多 4 个 OCPU（ARM Ampere A1）             │
│    - 最多 24GB 内存                              │
│    - 最多 200GB 存储                             │
│    - 永久免费，不过期                            │
│                                                 │
│  x86 实例：                                     │
│    - 2 个实例，每个 1/8 OCPU + 1GB RAM           │
│    - 永久免费                                    │
│                                                 │
│  总计：最多 4 台服务器                            │
│  磁盘配额：200GB（所有实例共享）                  │
│                                                 │
│  额外：$300 免费额度（30 天，用于付费服务）       │
└─────────────────────────────────────────────────┘
```

### 推荐配置（运行 Hermes Agent）

```
方案 A：1 台 ARM 服务器（推荐）
  - 4 OCPU + 24GB RAM + 100GB 存储
  - 操作系统：Ubuntu 22.04 ARM
  - 足够运行 Hermes Agent + 多个服务

方案 B：1 台 ARM + 2 台 x86
  - ARM：2 OCPU + 12GB RAM（运行 Hermes）
  - x86 × 2：各 1/8 OCPU + 1GB RAM（其他用途）
```

> 来源：
> [1] Oracle Cloud 官方 https://www.oracle.com/cloud/free/
> [2] 知乎 "甲骨文免费永久四台云服务器开通指南"
> [3] Agenteer "How to Host OpenClaw 24/7 for Free on Oracle Cloud"


══════════════════════════════════════════════
  注册 Oracle Cloud（中国大陆用户）
══════════════════════════════════════════════

### 前提条件

```
1. VPN（必须）
   - 注册时需要非中国大陆 IP
   - 推荐：美国、日本、新加坡 IP
   - IP 要"干净"（没被大量注册用过）

2. 信用卡（必须）
   - 必须是真实信用卡（非虚拟卡、非预付卡）
   - 推荐类型：VISA 或 Mastercard
   - 美国运通（AMEX）也可以
   - 中国银联卡不行
   
3. 真实信息
   - 真实姓名（与信用卡一致）
   - 真实地址
   - 手机号（不验证，但要填）
```

### 信用卡成功率（来自社区经验）

```
成功率较高的卡：
  ✓ 招商银行 VISA/Mastercard
  ✓ 工商银行 VISA
  ✓ 建设银行 VISA
  ✓ 美国运通卡

成功率较低的卡：
  ✗ 虚拟卡（100% 失败）
  ✗ 预付卡
  ✗ 中国银联卡
  ✗ 部分银行的双币卡
```

### 注册步骤（简化版）

```
1. 打开 VPN（美国/日本/新加坡 IP）

2. 访问注册页面
   https://www.oracle.com/cn/cloud/free/
   或英文版：https://www.oracle.com/cloud/free/

3. 填写注册信息
   - 国家/地区：选择与信用卡发行国一致
   - 姓名：与信用卡一致
   - 地址：真实地址（可以用家庭地址）
   - 手机号：任意（不验证）

4. 添加信用卡
   - Oracle 会测试扣款 $1（会退还）
   - 确保信用卡已开通国际支付

5. 验证邮箱
   - 点击邮件中的验证链接

6. 登录控制台
   - https://cloud.oracle.com
```

### 常见问题

```
Q: 注册失败怎么办？
A: 这是常态，很多人尝试 10+ 次才成功。
   尝试方法：
   - 换一个 VPN 节点
   - 换一张信用卡
   - 清除浏览器 cookie 重试
   - 换一个邮箱注册

Q: 显示"信用卡验证失败"？
A: 最常见原因：
   - 虚拟卡/预付卡（必须用真实信用卡）
   - 信用卡未开通国际支付
   - IP 不干净（被标记）

Q: 显示"超出容量"？
A: ARM 实例在某些区域容量已满。
   尝试方法：
   - 换一个区域（如从 US 换到 JP 或 KR）
   - 多次重试（容量会动态变化）
   - 使用自动创建脚本（GitHub 上有）

Q: 注册成功后被封号？
A: 少数情况，原因可能是：
   - 使用虚拟卡
   - IP 频繁变动
   - 违反使用条款
```

> 来源：
> [1] 接码号 "Oracle甲骨文云免费VPS注册及使用保姆级教程"
> [2] V2EX "你们是怎么成功申请Oracle云的？"
> [3] 稀土掘金 "如何获取oracle cloud永久免费的vps"
> [4] YouTube "2026最新甲骨文云注册教程及避坑指南"


══════════════════════════════════════════════
  创建 ARM 实例（4核24G）
══════════════════════════════════════════════

注册成功后，创建服务器：

```
1. 登录 Oracle Cloud 控制台
   https://cloud.oracle.com

2. 左侧菜单 → Compute → Instances → Create Instance

3. 配置：
   - Name: hermes-agent
   - Image: Ubuntu 22.04 (aarch64)
   - Shape: VM.Standard.A1.Flex
   - OCPU: 4（拉满）
   - Memory: 24 GB（拉满）
   - Boot volume: 100 GB

4. 网络：
   - 创建新的 VCN（或使用默认）
   - 创建新的公网子网

5. SSH 密钥：
   - 下载或粘贴你的公钥
   - 保存好私钥！

6. 创建
   - 等待 1-2 分钟
```

### 如果显示"超出容量"

```
方法 1：换区域
  - 从 US 换到 Japan (Tokyo) 或 South Korea (Seoul)
  - 不同区域容量不同

方法 2：多次重试
  - 容量动态变化
  - 每天尝试几次

方法 3：使用自动脚本
  - GitHub 上有 "oracle-cloud-free-instance" 项目
  - 自动检测容量并创建
```

> 来源：
> [1] Medium "Setup Always Free VPS with 4 OCPU, 24GB RAM"
> [2] 知乎 "甲骨文免费永久四台云服务器开通指南"


══════════════════════════════════════════════
  部署 Hermes Agent
══════════════════════════════════════════════

### 步骤 1：连接服务器

```bash
ssh ubuntu@<你的服务器IP> -i ~/.ssh/your_key
```

### 步骤 2：安装 Hermes Agent

```bash
# 一键安装
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

### 步骤 3：配置模型

```bash
# 启动 Hermes
hermes

# 配置模型（使用你的小米 token）
hermes model
# 选择 Xiaomi MiMo，输入你的 API Key
```

### 步骤 4：配置 Gateway（可选，接入 Telegram 等）

```bash
hermes gateway setup
# 按提示配置 Telegram Bot Token

# 启动 Gateway
hermes gateway install
hermes gateway start
```

### 步骤 5：设置开机自启

```bash
# 使用 systemd
sudo systemctl enable hermes-gateway
sudo systemctl start hermes-gateway
```

### 步骤 6：验证

```bash
# 检查状态
hermes status
hermes gateway status

# 测试
hermes chat -q "Hello, are you working?"
```

> 来源：
> [1] Hermes Agent 官方文档 https://hermes-agent.nousresearch.com/docs/
> [2] Reddit r/hermesagent "Has anyone found a good guide for setting up Hermes on Oracle Cloud"
> [3] Evolution Host "How to Set Up Hermes on a VPS"


══════════════════════════════════════════════
  中国大陆访问 Oracle Cloud
══════════════════════════════════════════════

### 网络访问

```
Oracle Cloud 服务器 → 中国大陆：
  - 直连速度取决于区域
  - 日本/韩国区域延迟较低（50-100ms）
  - 美国区域延迟较高（150-300ms）

中国大陆 → Oracle Cloud 服务器：
  - SSH：需要 VPN 或代理
  - Hermes Gateway（Telegram）：服务器直连，不需要 VPN
  - API 调用（小米等）：服务器直连，不需要 VPN
```

### 推荐区域

```
对中国大陆用户最友好的区域：
  1. Japan (Tokyo) - ap-tokyo-1
     延迟低，容量相对充足
  2. South Korea (Seoul) - ap-seoul-1
     延迟低
  3. Japan (Osaka) - ap-osaka-1
     备选

不推荐：
  - US 区域（延迟高）
  - Europe 区域（延迟高）
```

### 保持连接

```
使用 tmux 或 screen 保持 SSH 会话：
  tmux new -s hermes
  # 运行 Hermes
  hermes
  # 断开：Ctrl+B, D
  # 重新连接：tmux attach -t hermes

或者使用 systemd 让 Hermes 在后台运行：
  hermes gateway install
  hermes gateway start
```

> 来源：
> [1] 社区经验汇总
> [2] Oracle Cloud 官方文档


══════════════════════════════════════════════
  费用总结
══════════════════════════════════════════════

```
┌─────────────────────────────────────────────────┐
│  费用明细                                        │
│                                                 │
│  Oracle Cloud 服务器：$0（Always Free 永久免费）  │
│  小米 MiMo API：使用你的 Token Plan              │
│  VPN：你已有                                      │
│  域名（可选）：免费（如 freenom）或付费           │
│                                                 │
│  总计：$0/月（不含 VPN 和 API 费用）              │
└─────────────────────────────────────────────────┘
```


══════════════════════════════════════════════
  替代方案（如果 Oracle 注册失败）
══════════════════════════════════════════════

```
1. Google Cloud $300 免费额度
   - 90 天有效
   - 到期后需要付费
   - 配置：e2-medium (2 vCPU, 4GB RAM)

2. AWS Free Tier
   - 12 个月免费
   - t2.micro (1 vCPU, 1GB RAM)
   - 配置较低

3. Azure Free Account
   - 12 个月免费
   - B1s (1 vCPU, 1GB RAM)
   - $200 额度（30 天）

4. Railway / Render
   - 有免费额度
   - 适合部署 Web 应用
   - 不适合长期运行 Agent
```

> 来源：
> [1] Google Cloud Free Tier https://cloud.google.com/free
> [2] AWS Free Tier https://aws.amazon.com/free/
> [3] Azure Free Account https://azure.microsoft.com/en-us/free/


══════════════════════════════════════════════
  参考来源
══════════════════════════════════════════════

[1] Oracle Cloud 免费套餐官方页面
    https://www.oracle.com/cloud/free/

[2] Oracle Cloud 中国区页面
    https://www.oracle.com/cn/cloud/free/

[3] 接码号, "Oracle甲骨文云免费VPS注册及使用保姆级教程"
    https://jiemahao.com/oracle-cloud-vps/

[4] 稀土掘金, "如何获取oracle cloud永久免费的vps(4C/24G)?"
    https://juejin.cn/post/7489479817647538202

[5] 知乎, "甲骨文免费永久四台云服务器开通指南"
    https://zhuanlan.zhihu.com/p/2001579089060983225

[6] YouTube, "2026最新甲骨文云注册教程及避坑指南"
    https://www.youtube.com/watch?v=atHGMm9ETf4

[7] V2EX, "你们是怎么成功申请Oracle云的？"
    https://www.v2ex.com/t/1090424

[8] Reddit r/hermesagent, "Has anyone found a good guide for setting up Hermes on Oracle Cloud"
    https://www.reddit.com/r/hermesagent/comments/1sjyolu/

[9] Agenteer, "How to Host OpenClaw 24/7 for Free on Oracle Cloud"
    https://agenteer.com/learn/tutorials/openclaw-oracle-cloud/

[10] Medium, "How I Deployed a 24/7 AI Agent for $0"
     https://medium.com/@ramoncasadogomez/how-i-deployed-a-24-7-ai-agent-for-0

[11] Reddit r/google_antigravity, "FYI - Gemini AI Pro includes $10 monthly Google Cloud Credits"
     https://www.reddit.com/r/google_antigravity/comments/1qpzgez/

[12] Google AI Plans 官方页面
     https://one.google.com/intl/en/about/google-ai-plans/

[13] Google Cloud Free Tier
     https://cloud.google.com/free

[14] Evolution Host, "How to Set Up Hermes on a VPS"
     https://evolution-host.com/blog/how-to-set-up-hermes-on-a-vps.php
