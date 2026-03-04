#!/bin/bash
# evolve.sh - Agent Skill Factory 进化导航员 (自动化预览与部署)

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo "[ERROR] Usage: ./evolve.sh <project-name>"
    exit 1
fi

FACTORY_DIR="/home/imovation/agent-skill-factory"

# 1. 执行构建
$FACTORY_DIR/core/build.sh $PROJECT_NAME
if [ $? -ne 0 ]; then exit 1; fi

# 2. 执行质量检查
$FACTORY_DIR/core/lint.sh $PROJECT_NAME
if [ $? -ne 0 ]; then exit 1; fi

# 3. 自动触发 OpenCode 预览展示
# 这里的输出会被 AI Agent 捕获并以 Markdown 块展示
echo -e "\n--- BEGIN SKILL PREVIEW ---"
cat "$FACTORY_DIR/projects/$PROJECT_NAME/SKILL.md"
echo -e "--- END SKILL PREVIEW ---\n"

echo "[WAIT] 预览已生成。请在对话框中确认：是否执行最终部署与双仓库同步？(y/n)"
