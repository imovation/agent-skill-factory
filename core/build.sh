#!/bin/bash
# build.sh - Agent Skill Factory 编译器

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo "[ERROR] Please specify a project name (e.g., ./build.sh ubuntu-ai-assistant)"
    exit 1
fi

PROJECT_DIR="/home/imovation/agent-skill-factory/projects/$PROJECT_NAME"
TEMPLATE_FILE="$PROJECT_DIR/src/SKILL.md.tpl"
OUTPUT_FILE="$PROJECT_DIR/SKILL.md"

if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "[ERROR] Template not found: $TEMPLATE_FILE"
    exit 1
fi

echo "[BUILD] Compiling skill for $PROJECT_NAME..."

# 1. 准备重建指令 (Reconstruction Instructions)
RECON_CMD=""
ASSETS_DIR="$PROJECT_DIR/assets"

if [ -d "$ASSETS_DIR" ]; then
    for asset in "$ASSETS_DIR"/*; do
        if [ -f "$asset" ]; then
            filename=$(basename "$asset")
            echo "[BUILD] Inlining asset: $filename"
            RECON_CMD+="\n### 重建文件: $filename\n"
            RECON_CMD+=" \`\`\`bash\n"
            RECON_CMD+=" mkdir -p $(dirname "$asset")\n"
            RECON_CMD+=" cat <<'EOF' > $asset\n"
            RECON_CMD+="$(cat "$asset")\n"
            RECON_CMD+="EOF\n"
            RECON_CMD+=" \`\`\`\n"
        fi
    done
fi

# 2. 注入到模板并生成最终文件
# 使用 Python 处理占位符替换，避免 sed 处理多行内容的复杂转义问题
python3 -c "
import sys
content = open('$TEMPLATE_FILE').read()
recon = '''$RECON_CMD'''
new_content = content.replace('{{RECONSTRUCT_ASSETS}}', recon)
with open('$OUTPUT_FILE', 'w') as f:
    f.write(new_content)
"

echo "[SUCCESS] Build complete: $OUTPUT_FILE"
