# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Mục đích thư mục

`[hoc-claude-code]` là thư mục **thực hành để học Claude Code**. Mỗi dự án nhỏ nằm trong một thư mục con riêng.

- Repo công khai: https://github.com/ngqacuongg/hoc-claude-code (remote `origin`, nhánh `main`).
- GitHub Pages lấy từ thư mục gốc của nhánh `main`: mọi file đẩy lên đều được đăng công khai tại https://ngqacuongg.github.io/hoc-claude-code/
- `gh` được cài ở `~/.local/bin/gh`. Shell không tương tác của Claude có thể không có thư mục này trong PATH, nên cần gọi bằng đường dẫn đầy đủ.

## Dự án

### `todo/`: todo-list hằng ngày
- Một file `index.html` duy nhất (HTML + CSS + JS thuần), không có build hay thư viện ngoài.
- Chạy bằng lệnh `open todo/index.html` (mở bằng trình duyệt mặc định). Bản trên web: https://ngqacuongg.github.io/hoc-claude-code/todo/
- Dữ liệu lưu trong `localStorage`, khoá `daily-todo-v1`, dạng `{ "YYYY-MM-DD": [{id, text, done}] }`. Khoá ngày theo giờ địa phương (hàm `keyOf`), không dùng UTC.
- Khi xem ngày hôm nay, `lastUnfinished()` tìm ngày gần nhất còn việc chưa xong để gợi ý chuyển sang hôm nay.
- Trong Browser pane của app, trang chạy dưới dạng `data:` URL nên `localStorage` bị chặn và dữ liệu không được lưu. Muốn kiểm tra tính năng lưu thì phải mở bằng trình duyệt thật.

## Cách làm việc với người dùng

- Trả lời bằng **tiếng Việt**. Code, tên file và commit message có thể dùng tiếng Anh.
- Người dùng đang học, nên khi làm việc hãy giải thích ngắn gọn *vì sao* chọn cách làm đó, không chỉ đưa kết quả.

## Công cụ đã đồng bộ từ claude.ai

Các plugin và skill sau đã có sẵn trong phiên (đồng bộ từ tài khoản claude.ai). Nên dùng chúng thay vì tự làm thủ công:

- **Plugin `design`**: design-critique, accessibility-review, design-system, design-handoff, ux-copy, user-research, research-synthesis. Các connector Figma, Slack, Notion, Linear, Asana, Atlassian, Intercom cần xác thực qua `/mcp` trước khi dùng.
- **Plugin `bio-research`**: PubMed, bioRxiv, ChEMBL, ClinicalTrials, Open Targets, Consensus, cùng các skill scRNA-seq QC, scvi-tools, nextflow.
- **Anthropic skills**: docx, xlsx, pptx, pdf, docs, deep-research, learn, skill-creator.
- **Connector Google**: Drive, Docs, Sheets, Slides, Gmail, Calendar.

## Skill cài thêm (cấp người dùng)

- **`anatomy`** (https://github.com/wheresryan22/anatomy, MIT): giải thích một ý tưởng kỹ thuật bằng hình isometric tương tác (SVG, có thể thêm WebGL/3D) và in ra PDF A4. Gọi bằng `/anatomy <yêu cầu>`.
  - Cài ở `~/.claude/skills/anatomy` (git clone) nên dùng được ở mọi dự án và không nằm trong repo này. Cập nhật bằng `git -C ~/.claude/skills/anatomy pull`.
  - Cần Node.js ≥ 20.10, và Chrome hoặc Chromium để skill tự kiểm tra hình.
  - File hình tạo ra trong repo này sẽ được đăng công khai qua GitHub Pages khi push.

## Hướng dẫn và bộ nhớ từ claude.ai

<!-- Claude Code không đọc được trực tiếp custom instructions hoặc memory của claude.ai chat.
     Hãy dán nội dung đó vào mục này. -->
