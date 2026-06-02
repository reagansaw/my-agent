---
created: 2026-06-02
status: in-progress
source: pro-kit 03「外部工具整合包 by 雷小蒙」
---

# 外部工具整合計畫（2026-06-02）

> 這份計畫是「外部工具整合包」訪談後產出的，列出所有你打算接到 Claude Code 的工具。
> **執行方式**：有空的時候打開這份文件跟 AI 說：「幫我挑一個來裝」，AI 會用網路搜尋查當下最新的整合方式，一步一步帶你裝，完成後把對應的 checklist 打勾。

## 決策原則速查

在選每個工具的路線前，優先順序是：

1. 🥇 **CLI**（`gh`、`gws-cli`、官方 CLI）— 不吃 context、最穩定
2. 🥈 **REST API + `.env`**（curl / Python requests）— 彈性最高、可精準控制
3. 🥉 **MCP**（`~/.claude.json` 的 `mcpServers`）— 只有 CLI + API 都不行時才用
4. 🔒 **瀏覽器控制**（Chrome DevTools MCP / Playwright）— 真的沒 API 才走這條

每個工具的「建議路線」欄位是初步判斷，實際執行時 AI 會即時用網路搜尋確認當下最新的最佳做法。

---

## 工具清單

### 🟢 Gmail — 已整合（2026-06-02）

- **用途**：讀信、搜尋舊信件、建回信草稿、整理重要來信
- **建議路線**：🥈 REST API（`gws-cli` 或 Gmail REST API + OAuth）
  - `gws-cli` 是 Google Workspace CLI 工具，可以一次搞定 Gmail + Calendar，優先試這條
  - 備選：直接用 Gmail REST API（需要 OAuth 2.0 + credentials.json）
- **執行時要查的事情**：
  - [ ] `gws-cli` 目前安裝方式與支援的 Gmail 操作（用 web search 查官方 README）
  - [ ] 如果 gws-cli 不夠用，Gmail REST API 的 OAuth scope 怎麼設最省事？
  - [ ] 需要哪些憑證？在哪取得？（Google Cloud Console → OAuth 2.0 Client）
- **安裝 checklist**：
  - [ ] 確認 `gws-cli` 是否仍為推薦方案（執行時 AI 查）
  - [ ] 安裝並完成 Google OAuth 授權
  - [ ] 跑驗證指令：「幫我看最近 3 封信的主旨」
  - [ ] 回來打勾 + 在「備註」欄記下踩坑
- **備註**：（執行完畢後寫這裡）

---

### 🟢 Google Calendar — 已整合（2026-06-02）

- **用途**：查行程、找空檔、建活動、搬時間
- **建議路線**：🥇 CLI（`gws-cli calendar`）
  - Google Calendar 和 Gmail 可以共用同一個 `gws-cli` 安裝 + OAuth 授權，裝一次兩個都搞定
- **執行時要查的事情**：
  - [ ] `gws-cli` 的 calendar 子指令支援哪些操作？（查 README）
  - [ ] 有沒有比 gws-cli 更好用的 Google Calendar CLI 方案？
  - [ ] 裝完 Gmail 那個 session 就能順手把 Calendar 一起搞定
- **安裝 checklist**：
  - [ ] 搭配 Gmail 一起裝（共用 OAuth 憑證）
  - [ ] 跑驗證指令：「今天的行程有什麼？」
  - [ ] 回來打勾 + 在「備註」欄記下踩坑
- **備註**：（執行完畢後寫這裡）

---

### ✅ Obsidian — 不需要額外整合

- **用途**：筆記與知識管理
- **狀態**：Obsidian 的筆記檔案（`.md`）就在你的電腦上，Claude Code 本來就能直接讀寫，不需要裝任何 MCP 或 API。
- **怎麼用**：直接跟 AI 說「讀我的 Obsidian vault 裡的 XXX 筆記」，然後告訴它路徑就行。
- **建議**：把你的 Obsidian vault 路徑加到 `CLAUDE.md` 裡，讓 AI 每次都知道筆記在哪。

---

### 🟡 Firecrawl — 尚未整合

- **用途**：抓網頁內容、整理文章重點、比較產品規格、搜尋網路資料
- **建議路線**：🥉 MCP（這是少數真的適合走 MCP 的工具）
  - Firecrawl 沒有實用的 CLI，MCP 是目前最順的接法
- **執行時要查的事情**：
  - [ ] Firecrawl MCP 目前的官方 npm 套件名是什麼？（查 `https://github.com/mendableai/firecrawl` 或 npm）
  - [ ] 免費方案的額度限制是多少？值不值得付費升級？
  - [ ] `~/.claude.json` 的 `mcpServers` 設定格式有沒有變？
- **安裝 checklist**：
  - [ ] 到 firecrawl.dev 註冊帳號取得 API key
  - [ ] 把 API key 存到 `~/.env.claude-tools`（key 名：`FIRECRAWL_API_KEY`）
  - [ ] 編輯 `~/.claude.json` 加入 Firecrawl MCP entry（AI 執行時查最新格式）
  - [ ] 重啟 Claude Code 載入新的 MCP
  - [ ] 跑驗證：「幫我抓 https://example.com 的主要內容」
  - [ ] 回來打勾 + 在「備註」欄記下踩坑
- **備註**：（執行完畢後寫這裡）

---

### 🟡 GitHub — 尚未整合

- **用途**：管理 repo、查 issues、建 PR、查最近更新
- **建議路線**：🥇 CLI（`gh`，GitHub 官方 CLI）
  - `gh` 是 GitHub 官方出的，穩定度最高、功能最完整、不吃 context
- **執行時要查的事情**：
  - [ ] 確認 `gh` 是否已安裝（`gh --version`）
  - [ ] 如果沒裝，macOS 上用 `brew install gh` 最快
  - [ ] `gh auth login` 完成授權後就能用了
- **安裝 checklist**：
  - [ ] 跑 `gh --version` 確認是否已安裝
  - [ ] 如果沒裝：`brew install gh`
  - [ ] 跑 `gh auth login` 完成 GitHub 授權（選 browser 登入最簡單）
  - [ ] 跑驗證：`gh repo list --limit 5` 看到你的 repos
  - [ ] 把 10 個常用 gh 指令記進 AI 分身（AI 幫你整理到 skill 或 CLAUDE.md）
  - [ ] 回來打勾 + 在「備註」欄記下踩坑
- **備註**：（執行完畢後寫這裡）

---

## 進度總覽

- 🟡 尚未整合：2 個（Firecrawl、GitHub）
- ✅ 無需整合：1 個（Obsidian）
- 🟢 已整合：2 個（Gmail、Google Calendar）
- 🔴 放棄：0 個

**下次執行建議**：先裝 GitHub（`gh` 最簡單，10 分鐘裝完），接著裝 `gws-cli`（Gmail + Calendar 一起搞定），最後才裝 Firecrawl MCP。

---

## 給未來 AI 執行時的指引（不要刪這段）

當用戶打開這份文件跟你說「幫我挑 [某個工具] 來裝」時，請按以下步驟：

### 1. 確認範圍

用 `AskUserQuestion` 確認：
- 你要整合 [工具名]，對嗎？
- 整合的主要用途是什麼？（從計畫文件的「用途」欄讀出來讓他確認）

### 2. 用網路搜尋查最新整合方式

**這一步絕對不要跳過，也不要用訓練資料裡的舊資訊。** 執行：

1. 用 WebSearch / WebFetch 查以下問題：
   - `"[工具名]" Claude Code MCP integration 2026`
   - `"[工具名]" official CLI tool`
   - `"[工具名]" REST API authentication`
2. 優先看官方文件、GitHub README、官方 blog 公告
3. 對照計畫文件的「建議路線」，看看有沒有更新/更好的方案
4. 把查到的結果整理成一段話告訴用戶，再用 `AskUserQuestion` 讓用戶拍板

### 3. 執行安裝

根據拍板的路線：

- **CLI 路線**：幫用戶安裝該 CLI 工具（brew / npm / pip，依官方推薦），引導完成 auth，跑驗證指令
- **API 路線**：引導取得 API key → 存到 `~/.env.claude-tools`（key 命名用大寫 + 底線）→ 在 `000_Agent/skills/` 建一個該服務的 skill（寫認證方式 + 常見 endpoint + 範例）
- **MCP 路線**：編輯 `~/.claude.json` 的 `mcpServers` 加入新 entry → 完成 auth → 重新載入 MCP

### 4. 驗證

用一個實際指令測試整合真的能用：
- GitHub → `gh repo list --limit 5`
- Gmail → 「幫我看最近 3 封信的主旨」
- Google Calendar → 「今天的行程有什麼？」
- Firecrawl → 「幫我抓 [某網址] 的主要內容」

### 5. 更新計畫文件

用 `Edit` 工具更新這份文件：
- 該工具區塊標題從 🟡 改成 🟢
- 安裝 checklist 全部打勾
- 備註欄寫：實際用了什麼路線、套件版本、踩坑、驗證指令
- 進度總覽數字調整

### 6. 告訴用戶下一步

「[工具名] 整合完成！剩下 [N] 個工具。建議一週後再挑下一個來裝，讓這個先用熟。」
