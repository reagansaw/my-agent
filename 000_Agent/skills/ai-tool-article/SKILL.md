---
name: ai-tool-article
description: Draft a structured Markdown article about an AI tool. Use when you want to write an introduction, review, or breakdown of an AI tool (e.g. Seedance 2.0, AI image generators, video AI, creative AI tools). Takes either a tool name with bullet notes, or an existing draft/notes, and outputs a complete structured Markdown article in Traditional Chinese. Trigger phrases include "幫我寫一篇關於 [AI 工具]", "整理成一篇文章", "寫 [工具名] 的介紹", "AI 工具介紹", "AI 工具評測".
when_to_use: Use when the user mentions a specific AI tool and wants to write an article, introduction, review, or structured breakdown. Also use when the user provides raw notes about an AI product and asks to organize them into a publishable piece.
---

# AI Tool Article Drafter

你幫用戶把 AI 工具的零散資訊，整理成一篇結構完整、可以直接發布的繁體中文 Markdown 文章。

## 輸入型態

用戶會提供以下其中一種：

**A 型：工具名 + 字條筆記**
例：「Seedance 2.0，強化動態一致性，支援多對象分工，做圖轉影片效果很好」

**B 型：已有草稿 / 心得筆記**
例：一段文字或段落，需要重新組織結構

如果用戶沒提供素材就觸發這個 skill，問一句：
「請告訴我工具名稱，以及你目前有的素材（字條、草稿、或任何想法都行）」

---

## 執行步驟

### 第 1 步：確認輸入與補問

讀取用戶的素材，判斷型態（A 或 B）。

**如果是 A 型（字條），補問最多 2 個問題**（問完就開始寫，不要超問）：
- 「你主要用這個工具來做什麼用途？」（若字條已有場景則跳過）
- 「有沒有你想比較的競品或前一版本？」（若沒提到比較就改成優缺點列表）

**如果是 B 型（草稿）**，直接確認：
「我會把你的草稿整理成下面這個結構，可以嗎？[列出結構大綱]」

---

### 第 2 步：起草文章

依照以下固定結構輸出，語言預設繁體中文（用戶若用英文寫筆記則改英文輸出）：

```
# [工具名稱] 完整介紹

## 這是什麼？
一段話說明這個工具是誰做的、主要用途是什麼、適合誰用。

## 主要功能
- **功能一**：說明
- **功能二**：說明
- **功能三**：說明
（列 3-5 個，挑最有代表性的）

## 實際使用場景
描述 2-3 個真實可操作的場景，讓讀者知道「我什麼時候會用到它」。

場景一：...
場景二：...

## 與其他工具相比（或：優缺點分析）
若有競品比較：

| 項目 | [此工具] | [競品 A] | [競品 B] |
|------|---------|---------|---------|
| 優勢 | ... | ... | ... |
| 限制 | ... | ... | ... |
| 價格 | ... | ... | ... |

若無比較對象，改為優缺點列表：
**優點**
- ...

**缺點 / 限制**
- ...

## 小技巧 / 加分使用方式
- 技巧一：...
- 技巧二：...
（2-4 個讓讀者馬上能用的 tips）

## 總結
一段話：這個工具適合誰、什麼情況下值得試、有沒有使用門檻。
```

**字數目標**：
- 工具快速介紹：400-600 字
- 完整評測 / 深度介紹：800-1200 字
- 若用戶沒指定，預設完整介紹長度

---

### 第 3 步：存檔

- 檔案名稱：`[工具名小寫]-article.md`（例：`seedance2-article.md`、`midjourney-article.md`）
- 存到當前工作目錄，除非用戶指定其他路徑
- 存完後告訴用戶完整路徑和字數

---

## 品質檢查（存檔前自驗）

在輸出前確認：
- [ ] 每個段落都有內容，沒有空白佔位符
- [ ] 表格格式正確（若有比較表）
- [ ] 小技巧至少 2 個
- [ ] 語氣一致（口語化但專業，不要太學術）
- [ ] 標題層級正確（H1 → H2，不混用）
