"""Gộp mọi briefs/YYYY-MM-DD.json vào trang brief/index.html và ghi ra briefs/index.html.

Mã trang (brief/) được đăng công khai, còn dữ liệu (briefs/) nằm trong .gitignore.
Nhúng dữ liệu thẳng vào HTML, không tải bằng fetch, nên trang mở được cả bằng
file:// lẫn trong Browser pane (nơi trang chạy dưới dạng data: URL).

Chạy: python3 -I brief/build.py
"""
import json
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
SRC = ROOT / "brief" / "index.html"
DATA_DIR = ROOT / "briefs"
OUT = DATA_DIR / "index.html"
MARKER = "/*__BRIEFS__*/null"

briefs = {}
for f in sorted(DATA_DIR.glob("*.json")):
    if not re.fullmatch(r"\d{4}-\d{2}-\d{2}", f.stem):
        continue
    try:
        briefs[f.stem] = json.loads(f.read_text(encoding="utf-8"))
    except (OSError, ValueError) as e:
        print(f"Bỏ qua {f.name}: {e}", file=sys.stderr)

template = SRC.read_text(encoding="utf-8")
if MARKER not in template:
    sys.exit(f"Không thấy {MARKER} trong {SRC}")

# Thay "</" để chuỗi trong dữ liệu không thể đóng thẻ <script> sớm.
payload = json.dumps(briefs, ensure_ascii=False).replace("</", "<\\/")
OUT.write_text(template.replace(MARKER, payload, 1), encoding="utf-8")
print(f"Đã ghi {OUT.relative_to(ROOT)} với {len(briefs)} bản tóm tắt")
