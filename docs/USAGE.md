# agent-skill-factory 使用说明 (Usage)

## 1. 环境准备 (Prerequisites)
- **操作系统**：Ubuntu 24.04 (本工厂目前主要支持此环境)。
- **核心依赖**：`bash`, `python3`, `git`, `xclip`。

## 2. 初始配置 (Configuration)
在根目录下创建并编辑 `.env` 文件，用于安全管理凭证：
```bash
GITHUB_TOKEN=你的GitHubToken
GITHUB_USER=你的GitHub用户名
```

## 3. 开发一个新技能 (Developing a New Skill)
1.  **初始化**：在 `projects/` 下创建一个以技能命名的文件夹。
2.  **创建源码**：在 `projects/<项目名>/src/` 下创建 `SKILL.md.tpl`。
3.  **注入代码 (可选)**：如果技能依赖 Python 或 Shell 脚本，请放在 `projects/<项目名>/assets/` 下。
4.  **放置占位符**：在 `.tpl` 文件中，在你希望显示脚本重建指令的地方放入 `{{RECONSTRUCT_ASSETS}}`。

## 4. 执行进化逻辑 (The Evolution Loop)
当你在当前会话中解决了一个问题，且用户已验证有效：
1.  **更新源码**：在 `projects/<项目名>/src/SKILL.md.tpl` 中整合新知识。
2.  **记录历史**：在 `projects/<项目名>/meta/CHANGELOG.md` 中记录本次进化的元数据（日期、AI模型名、变更内容）。
3.  **构建与发布**：
    ```bash
    cd /home/imovation/agent-skill-factory
    ./core/deploy.sh <项目名>
    ```

## 5. IDE 辅助工具 (IDE Utilities)
工厂提供了一套 CLI 辅助工具来提升开发体验：
- **预览成品**：`./core/preview.sh <项目名>` (构建并查看最终输出)。
- **质量检查**：`./core/lint.sh <项目名>` (验证是否符合铁律)。

## 6. 最佳实践 (Best Practices)
- **禁止瞎猜**：若不确定用户意图，请务必先请求明确。
- **自包含校验**：生成 `SKILL.md` 后，建议用 `cat` 命令检查脚本注入内容是否正确。
- **双仓库同步确认**：执行 `deploy.sh` 后观察终端日志，确保两个远程仓库均成功推送。
