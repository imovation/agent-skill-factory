#!/bin/bash
# deploy.sh - 通用部署与双仓库同步器

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo "[ERROR] Usage: ./deploy.sh <project-name>"
    exit 1
fi

# 加载环境变量
source /home/imovation/agent-skill-factory/.env

FACTORY_DIR="/home/imovation/agent-skill-factory"
PROJECT_DIR="$FACTORY_DIR/projects/$PROJECT_NAME"
SKILLS_REPO_DIR="/home/imovation/skills_repo"
LOCAL_PRODUCTION_DIR="/home/imovation/.config/opencode/skills/$PROJECT_NAME"

# 1. 运行构建
$FACTORY_DIR/core/build.sh $PROJECT_NAME
if [ $? -ne 0 ]; then exit 1; fi

# 2. 本地生产环境部署
mkdir -p "$LOCAL_PRODUCTION_DIR"
cp "$PROJECT_DIR/SKILL.md" "$LOCAL_PRODUCTION_DIR/SKILL.md"
echo "[DEPLOY] Local production updated."

# 3. 同步至工厂仓库 (agent-skill-factory)
cd "$FACTORY_DIR"
git add .
git commit -m "Evolution: [$PROJECT_NAME] updated by AI Factory"
git push origin main

# 4. 同步至分发仓库 (skills)
if [ -d "$SKILLS_REPO_DIR" ]; then
    mkdir -p "$SKILLS_REPO_DIR/$PROJECT_NAME"
    cp "$PROJECT_DIR/SKILL.md" "$SKILLS_REPO_DIR/$PROJECT_NAME/SKILL.md"
    cd "$SKILLS_REPO_DIR"
    git add .
    git commit -m "Release: $PROJECT_NAME updated"
    git push origin main
    echo "[DEPLOY] Skills repository synced."
else
    echo "[WARN] Skills repository not found locally. Skipping sync."
fi

echo "[FINISH] All tasks completed for $PROJECT_NAME."
