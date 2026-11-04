# hoc-plugin

Plugin Claude Code nhỏ, làm ra để học cấu trúc của một plugin. Nó chỉ có tác dụng trong repo `hoc-claude-code`.

## Thành phần

| Phần | File | Tác dụng |
|---|---|---|
| Manifest | `.claude-plugin/plugin.json` | Tên, phiên bản, mô tả |
| Skill | `skills/new-project/SKILL.md` | `/hoc-plugin:new-project <tên> <mô tả>` tạo thư mục dự án con với một `index.html` thuần và thêm mục vào `CLAUDE.md` |
| Hook | `hooks/hooks.json` + `hooks/session-start.sh` | Khi mở phiên trong repo này, hiện một dòng: có những dự án nào, bao nhiêu file chưa commit. Ở repo khác thì im lặng |
| Hook | `hooks/hooks.json` + `hooks/stop-remind-commit.sh` | Sau mỗi lượt trả lời của Claude, nếu repo còn file chưa commit thì hiện một dòng nhắc. Chỉ nhắc, không chặn |

Plugin không có MCP server, không gửi dữ liệu đi đâu và không sửa file ngoài repo.

## Cài

Từ thư mục gốc của repo:

```
claude plugin marketplace add ./
claude plugin install hoc-plugin@hoc-claude-code
```

Muốn thử mà không cài: `claude --plugin-dir ./hoc-plugin`.

Gỡ cài: `claude plugin uninstall hoc-plugin@hoc-claude-code`.
