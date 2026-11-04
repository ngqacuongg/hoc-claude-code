---
name: new-project
description: "Tạo một dự án nhỏ mới trong repo hoc-claude-code theo đúng quy ước: một thư mục con, một file index.html thuần (HTML + CSS + JS, không build, không thư viện ngoài), và một mục mới trong CLAUDE.md. Dùng khi người dùng muốn bắt đầu một dự án thực hành mới."
argument-hint: "<tên-thư-mục> <mô tả ngắn>"
---

# /hoc-plugin:new-project

Tạo dự án thực hành mới trong repo hiện tại. Đối số người dùng gõ: `$ARGUMENTS`

## Các bước

1. **Đọc đối số.** Từ đầu tiên là tên thư mục (chữ thường, nối bằng `-`, ví dụ `pomodoro`). Phần còn lại là mô tả. Nếu thiếu tên hoặc mô tả, hỏi lại người dùng một câu rồi dừng.

2. **Kiểm tra trùng.** Nếu thư mục đó đã tồn tại, báo cho người dùng và dừng. Không ghi đè.

3. **Học phong cách từ dự án có sẵn.** Đọc phần `<style>` của `todo/index.html` và dùng lại bảng biến màu (`--bg`, `--card`, `--text`, `--muted`, `--line`, `--accent`…), kể cả khối `prefers-color-scheme: dark`, để các dự án trông đồng bộ.

4. **Tạo `<tên>/index.html`** với:
   - `<html lang="vi">`, có `meta viewport`, tiêu đề tiếng Việt.
   - Toàn bộ CSS và JS nằm trong file, không tải gì từ mạng.
   - Một phiên bản tối thiểu nhưng chạy được của ý tưởng trong mô tả.
   - Nếu cần lưu dữ liệu thì dùng `localStorage` với khoá `<tên>-v1`.

5. **Cập nhật `CLAUDE.md`.** Thêm một mục `### \`<tên>/\`: <mô tả>` vào phần `## Dự án`, cùng kiểu với mục `todo/`: cách chạy (`open <tên>/index.html`), link web `https://ngqacuongg.github.io/hoc-claude-code/<tên>/`, và khoá `localStorage` nếu có.

6. **Báo lại** bằng tiếng Việt: đã tạo file nào, cách mở thử, và nhắc rằng khi push lên `main` thì trang sẽ được đăng công khai qua GitHub Pages. Không tự commit hay push.
