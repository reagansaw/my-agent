#!/usr/bin/env bash
# sync-health.sh
# 驗證 Claude Code 跨裝置同步架構是否健康
# 由 pro-kit 07 生成 · by 雷蒙
# 建議每週五跑一次（搭配週複盤）
#
# 用法：bash 000_Agent/scripts/sync-health.sh

set -e

MOTHER="/Users/reagansaw/Google Drive/My Drive/my-agent"
FAIL=0

echo "🩺 sync-health.sh 開始體檢..."
echo "時間：$(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# ────────────────────────────────────────────
# 檢查 1：~/.claude/ 底下的 symlink 指向是否存在
# ────────────────────────────────────────────
echo "[1/4] 檢查 ~/.claude/ symlink..."
for item in settings.json skills; do
  link="$HOME/.claude/$item"
  if [ -L "$link" ]; then
    target=$(readlink "$link")
    if [ -e "$target" ]; then
      echo "  ✅ $item → $target"
    else
      echo "  ❌ $item → $target（target 不存在！）"
      FAIL=$((FAIL+1))
    fi
  elif [ -e "$link" ]; then
    echo "  ⚠️  $item 是一般檔案（可能是雲端把 symlink 吃掉了）"
    FAIL=$((FAIL+1))
  else
    echo "  ⚪ $item 不存在（可能尚未設定）"
  fi
done

# ────────────────────────────────────────────
# 檢查 2：settings.json 在母體內且可讀
# ────────────────────────────────────────────
echo ""
echo "[2/4] 檢查 settings.json..."
SETTINGS="$MOTHER/.claude/settings.json"
if [ -f "$SETTINGS" ]; then
  MCP_COUNT=$(python3 -c "import json; d=json.load(open('$SETTINGS')); print(len(d.get('mcpServers',{})))" 2>/dev/null || echo "?")
  echo "  ✅ settings.json 可讀取（MCP servers：$MCP_COUNT 個）"
else
  echo "  ❌ settings.json 不在母體路徑：$SETTINGS"
  FAIL=$((FAIL+1))
fi

# ────────────────────────────────────────────
# 檢查 3：關鍵 skill 讀得到
# ────────────────────────────────────────────
echo ""
echo "[3/4] 檢查 skill 可讀取..."
for skill in skill-creator ai-tool-article; do
  skill_file="$HOME/.claude/skills/$skill/SKILL.md"
  if [ -f "$skill_file" ]; then
    echo "  ✅ $skill/SKILL.md 可讀取"
  else
    echo "  ⚠️  $skill 讀不到（skill 未安裝或 symlink 斷了）"
  fi
done

# ────────────────────────────────────────────
# 檢查 4：MEMORY.md 可讀取
# ────────────────────────────────────────────
echo ""
echo "[4/4] 檢查記憶系統..."
MEMORY="$MOTHER/000_Agent/memory/MEMORY.md"
if [ -f "$MEMORY" ]; then
  LINES=$(wc -l < "$MEMORY" | tr -d ' ')
  echo "  ✅ MEMORY.md 可讀取（$LINES 行）"
else
  echo "  ❌ MEMORY.md 讀不到：$MEMORY"
  FAIL=$((FAIL+1))
fi

# ────────────────────────────────────────────
# 結果
# ────────────────────────────────────────────
echo ""
echo "────────────────────────────────────────"
if [ "$FAIL" = "0" ]; then
  echo "🎉 全部正常！你的 AI 分身活著。"
else
  echo "⚠️  發現 $FAIL 個問題。"
  echo "   建議檢查步驟："
  echo "   1. 跑 ls -la ~/.claude/ 確認 symlink 狀態"
  echo "   2. 確認 Google Drive 有在同步"
  echo "   3. 若嚴重，從 ~/claude-backup-* 還原：rm -rf ~/.claude && mv ~/claude-backup-YYYYMMDD ~/.claude"
  exit 1
fi
