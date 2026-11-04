#!/bin/sh
# Stop hook: sau mỗi lượt trả lời của Claude, nếu repo hoc-claude-code còn file
# chưa commit thì hiện một dòng nhắc. Chỉ nhắc (systemMessage), không chặn Claude.
# Giống session-start.sh: mọi lỗi đều thoát với mã 0 để không làm hỏng phiên.

dir="${CLAUDE_PROJECT_DIR:-$PWD}"
cd "$dir" 2>/dev/null || exit 0
git remote get-url origin 2>/dev/null | grep -q 'hoc-claude-code' || exit 0

changed=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
[ "$changed" -gt 0 ] 2>/dev/null || exit 0

printf '{"systemMessage":"Nhắc: còn %s file chưa commit trong hoc-claude-code."}\n' "$changed"
exit 0
