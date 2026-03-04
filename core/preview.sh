#!/bin/bash
# preview.sh - 技能成品预览器

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo "[ERROR] Usage: ./preview.sh <project-name>"
    exit 1
fi

FACTORY_DIR="/home/imovation/agent-skill-factory"
$FACTORY_DIR/core/build.sh $PROJECT_NAME

SKILL_FILE="$FACTORY_DIR/projects/$PROJECT_NAME/SKILL.md"

echo -e "\n=================================================================="
echo -e "   PREVIEWING PRODUCTION SKILL: $PROJECT_NAME"
echo -e "==================================================================\n"

cat "$SKILL_FILE"

echo -e "\n=================================================================="
echo -e "   END OF PREVIEW"
echo -e "==================================================================\n"
