# AI 大腦遷移手冊

> 這份文件是 pro-kit 07 生成，記錄你的 AI 分身架構。
> 未來換新電腦、或換新 AI 時，照這份走就能一鍵接管。

---

## 當前架構

| 項目 | 內容 |
|:--|:--|
| 母體資料夾 | `/Users/reagansaw/Google Drive/My Drive/my-agent/` |
| 同步管道 | Google Drive |
| GitHub repo | 已初始化本地 repo，待推到遠端（見下方步驟） |
| 體檢腳本 | `000_Agent/scripts/sync-health.sh` |
| 體檢頻率 | 每週一次（建議週五） |
| 最後更新 | 2026-06-02 |

### symlink 清單

| `~/.claude/` 項目 | 指向 |
|:--|:--|
| `skills/` | Google Drive `000_Agent/skills/` |
| `settings.json` | Google Drive `.claude/settings.json` |

### 已安裝的 Skills

- `skill-creator` — 幫你建新 Skill
- `ai-tool-article` — AI 工具介紹文草稿

### 已整合的外部工具

- Gmail — `gws` CLI（`~/.npm-global/bin/gws`）
- Google Calendar — `gws` CLI
- Firecrawl MCP — settings.json 已設定
- Playwright MCP — settings.json 已設定

---

## 情境 1：推 GitHub 私有 repo（現在要做）

本地 git 已初始化。要推到 GitHub：

```bash
# 步驟 1：到 github.com 建一個私有 repo，名稱建議：my-agent
# 步驟 2：在終端機執行：

cd "/Users/reagansaw/Google Drive/My Drive/my-agent"
git remote add origin git@github.com:[你的GitHub帳號]/my-agent.git
git push -u origin main
```

之後每次有重大改動，commit + push：

```bash
cd "/Users/reagansaw/Google Drive/My Drive/my-agent"
git add -A
git commit -m "update: [描述改了什麼]"
git push
```

---

## 情境 2：換一台新電腦（macOS）

```bash
# 步驟 1：新電腦安裝 Claude Code
# 步驟 2：登入同一個 Google 帳號，等 Google Drive 同步完成
# 步驟 3：在終端機建立 symlink

MOTHER="$HOME/Library/CloudStorage/GoogleDrive-properties.saw@gmail.com/My Drive/my-agent"
# （確認你的 Google Drive 路徑，可用 ls ~/Library/CloudStorage/ 查）

mkdir -p "$HOME/.claude"

# 建立 symlink
ln -sf "$MOTHER/.claude/settings.json" "$HOME/.claude/settings.json"
ln -sf "$MOTHER/000_Agent/skills" "$HOME/.claude/skills"

# 步驟 4：安裝 gws CLI
export PATH="$HOME/.npm-global/bin:$PATH"
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
npm install -g @googleworkspace/cli

# 步驟 5：gws 重新授權（每台電腦各自授權，憑證不跨機）
mkdir -p ~/.config/gws
# 把 client_secret.json 放到 ~/.config/gws/client_secret.json
gws auth login

# 步驟 6：Claude Code 重新登入
claude auth login

# 步驟 7：跑體檢
bash "$MOTHER/000_Agent/scripts/sync-health.sh"
```

---

## 情境 3：換新 AI 大腦（Codex / Gemini / 未來新產品）

你的 `CLAUDE.md` 和 `000_Agent/` 是 AI 無關的資料。給新 AI 讀，只需要：

1. 確認新 AI 的規則檔命名（Codex 讀 `AGENTS.md`、Cursor 讀 `.cursorrules`）
2. 加一條 symlink：
   ```bash
   MOTHER="/Users/reagansaw/Google Drive/My Drive/my-agent"
   ln -s "$MOTHER/CLAUDE.md" "$MOTHER/AGENTS.md"    # Codex 用
   ```
3. Memory、Skills 的復用取決於新 AI 是否支援同等機制

---

## 情境 4：備份還原（出事時用）

```bash
# 查看有哪些備份
ls ~/claude-backup-*/

# 還原（換成你的實際備份路徑）
rm -rf ~/.claude
mv ~/claude-backup-20260602-203336 ~/.claude
```

---

## 每週維護清單（5 分鐘）

```bash
# 跑體檢
bash "/Users/reagansaw/Google Drive/My Drive/my-agent/000_Agent/scripts/sync-health.sh"

# 如果有改動，commit
cd "/Users/reagansaw/Google Drive/My Drive/my-agent"
git add -A
git commit -m "weekly: [本週主要改了什麼]"
git push  # 如果已推到 GitHub
```
