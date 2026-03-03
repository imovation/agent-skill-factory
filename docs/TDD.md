# agent-skill-factory 技术方案文档 (TDD)

## 1. 架构总览 (System Overview)
系统采用“源码-编译-发布”三层解耦架构。

- **源码层 (Source Layer)**：`projects/*/src/SKILL.md.tpl` 和 `projects/*/assets/`。
- **核心逻辑层 (Core Logic)**：`core/build.sh` 和 `core/deploy.sh`。
- **发布层 (Release Layer)**：生成的成品 `SKILL.md`（推送到 `skills` 仓库）。

## 2. 核心组件 (Core Components)

### 2.1 编译器 (core/build.sh)
- **输入**：`.tpl` 源码、`assets/` 文件夹。
- **逻辑**：扫描 `assets/` 下的所有文件，读取内容并转化为明文 Heredoc 代码块。
- **输出**：在项目根目录下生成最终的 `SKILL.md`。

### 2.2 部署器 (core/deploy.sh)
- **输入**：项目名称。
- **逻辑**：
    1. 调用 `build.sh` 编译。
    2. 复制成品到 OpenCode 生产路径。
    3. 通过 `git` 同步至工厂仓库。
    4. 通过 `git` 同步至分发仓库 (Skills Repo)。

### 2.3 状态管理 (meta/CHANGELOG.md)
- 每个项目拥有独立的进化日志，记录时间、模型、变更等元数据。

## 3. 核心机制：自包含资产注入 (Self-Contained Injection)
系统会在 `SKILL.md` 中注入一段指令，其格式如下：
```bash
cat <<'EOF' > /path/to/asset.py
[FILE_CONTENT]
EOF
```
当 Agent 加载 Skill 时，若检测到资产丢失，将能够自动根据该指令重构资产。

## 4. 进化铁律实施
- **进化脚本集成**：部署脚本集成模型名读取和用户显式确认逻辑。
- **安全隔离**：敏感 Token 存储在 `.env`，不进入任何仓库。
