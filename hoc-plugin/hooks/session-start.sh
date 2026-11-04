#!/bin/sh
# SessionStart hook: khi mở phiên trong repo hoc-claude-code, in một dòng tóm tắt
# (có những dự án nào, bao nhiêu file chưa commit). Ở repo khác thì im lặng.
# Hook không bao giờ được làm hỏng phiên, nên mọi lỗi đều thoát với mã 0.

dir="${CLAUDE_PROJECT_DIR:-$PWD}"
cd "$dir" 2>/dev/null || exit 0

# Chỉ chạy trong repo này: nhận diện qua remote origin.
git remote get-url origin 2>/dev/null | grep -q 'hoc-claude-code' || exit 0

# Dự án = thư mục con cấp 1 có index.html.
projects=$(for f in */index.html; do [ -f "$f" ] && dirname "$f"; done | tr '\n' ' ' | sed 's/ $//')
[ -n "$projects" ] || projects="(chưa có)"

changed=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

# systemMessage: hiện cho người dùng thấy. Tên thư mục không chứa dấu ngoặc kép
# theo quy ước repo, nên ghép chuỗi JSON trực tiếp là đủ.
printf '{"systemMessage":"hoc-claude-code: dự án [%s], %s file chưa commit. Tạo dự án mới: /hoc-plugin:new-project"}\n' "$projects" "$changed"
exit 0
