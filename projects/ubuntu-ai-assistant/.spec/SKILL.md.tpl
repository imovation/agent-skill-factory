# ubuntu-ai-assistant (Skill Definition)

此 Skill 专为协助 Ubuntu 24.04.4 LTS (AMD64) 新手在 Windows 远程桌面 (RDP) 环境下开发 AI (OpenCode/OpenClaw) 而设计。

## 环境基准
- **OS:** Ubuntu 24.04.4 LTS
- **Access:** Windows Remote Desktop (XRDP)
- **Primary Use:** AI Development (OpenCode, OpenClaw)

## 1. Ubuntu 基础操作 (RDP 优化版)
新手在 RDP 下最常见的问题是黑屏、卡顿或 Session 冲突。

### 1.1 系统更新与基础工具
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git vim htop build-essential
```

### 1.2 路径管理与工作空间 (新手必看)
在 OpenCode 中工作时，建议始终处于项目根目录下。

### 1.3 RDP 剪贴板与图片粘贴 (正式解决方案)
在 Ubuntu 24.04 的 RDP (GNOME Remote Desktop) 环境下，直接粘贴截图可能失效。

#### 1.3.1 核心修复脚本
如果粘贴失效，请执行以下指令重建并启动修复桥接器：

{{RECONSTRUCT_ASSETS}}

#### 1.3.2 配置自启动
确保桥接器开机自动运行：
```bash
mkdir -p ~/.config/autostart
cat <<EOF > ~/.config/autostart/rdp-clipboard-bridge.desktop
[Desktop Entry]
Type=Application
Exec=python3 /home/imovation/agent-skill-factory/projects/ubuntu-ai-assistant/assets/rdp-clipboard-bridge.py
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=RDP Clipboard Bridge
EOF
```

## 2. AI 开发工具 (OpenCode/OpenClaw)
(后续根据需求进化)
