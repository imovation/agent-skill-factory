#!/bin/bash
# lint.sh - Agent Skill Factory 质量检查器

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo "[ERROR] Usage: ./lint.sh <project-name>"
    exit 1
fi

SKILL_FILE="/home/imovation/agent-skill-factory/projects/$PROJECT_NAME/SKILL.md"

if [ ! -f "$SKILL_FILE" ]; then
    echo "[ERROR] Skill file not found. Please run build first."
    exit 1
fi

echo "[LINT] Checking skill quality for $PROJECT_NAME..."
ERROR_COUNT=0

# 1. 检查零噪声铁律
if grep -Ei "Evolution History|CHANGELOG|Evolution:" "$SKILL_FILE" > /dev/null; then
    echo "[FAIL] Zero Noise Rule violated: History/Logs found in production SKILL.md"
    ((ERROR_COUNT++))
fi

# 2. 检查占位符残留
if grep "{{RECONSTRUCT_ASSETS}}" "$SKILL_FILE" > /dev/null; then
    echo "[FAIL] Build Error: Unresolved {{RECONSTRUCT_ASSETS}} placeholder found."
    ((ERROR_COUNT++))
fi

# 3. 检查自包含性 (如果项目有 assets)
ASSETS_DIR="/home/imovation/agent-skill-factory/projects/$PROJECT_NAME/assets"
if [ "$(ls -A $ASSETS_DIR)" ] && ! grep "### 重建文件:" "$SKILL_FILE" > /dev/null; then
    echo "[FAIL] Engineering Rule violated: Assets exist but no reconstruction instructions found."
    ((ERROR_COUNT++))
fi

if [ $ERROR_COUNT -eq 0 ]; then
    echo "[SUCCESS] Skill passes all linting rules."
    exit 0
else
    echo "[ERROR] Linting failed with $ERROR_COUNT errors."
    exit 1
fi
