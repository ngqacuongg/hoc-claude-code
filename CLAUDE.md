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
- Giao diện sáng/tối/tự động lưu ở khoá riêng `daily-todo-theme`, áp dụng qua thuộc tính `data-theme` trên `<html>`.
- Nút Xuất/Nhập ở cuối trang: xuất ra file JSON cùng định dạng trên; nhập thì gộp vào dữ liệu hiện có và bỏ qua việc trùng `id`.
- Khi xem ngày hôm nay, `lastUnfinished()` tìm ngày gần nhất còn việc chưa xong để gợi ý chuyển sang hôm nay.
- Trong Browser pane của app, trang chạy dưới dạng `data:` URL nên `localStorage` bị chặn và dữ liệu không được lưu. Muốn kiểm tra tính năng lưu thì phải mở bằng trình duyệt thật.

### `pomodoro/`: Đồng hồ Pomodoro 25/5 phút, đếm số phiên trong ngày
- Một file `index.html` duy nhất, cùng bảng màu với `todo/`. Chạy bằng `open pomodoro/index.html`. Bản trên web: https://ngqacuongg.github.io/hoc-claude-code/pomodoro/
- Dữ liệu lưu trong `localStorage`, khoá `pomodoro-v1`, dạng `{ "YYYY-MM-DD": số phiên tập trung đã xong }`.
- Thời gian còn lại tính từ mốc kết thúc `endAt`, không trừ dần mỗi giây, vì trình duyệt làm chậm `setInterval` khi tab bị ẩn.

### `brief/`: trang xem todo-list buổi sáng
- `brief/index.html` là giao diện; `brief/build.py` gộp mọi `briefs/YYYY-MM-DD.json` rồi nhúng thẳng vào HTML, ghi ra `briefs/index.html`. Nhúng thay vì `fetch` để trang mở được bằng `file://` và trong Browser pane.
- Thư mục `briefs/` (dữ liệu, có nội dung trò chuyện) nằm trong `.gitignore`, không lên Pages. Bản trên web (https://ngqacuongg.github.io/hoc-claude-code/brief/) chỉ hiện dữ liệu mẫu.
- Dữ liệu do tác vụ định kỳ `morning-todo-brief` (8h sáng, `~/.claude/scheduled-tasks/morning-todo-brief/SKILL.md`) tạo. Đổi cấu trúc JSON thì sửa cả trang lẫn lời nhắn của tác vụ.
- Mở: `python3 -I brief/build.py && open briefs/index.html`. Trạng thái đã xong lưu ở `localStorage`, khoá `brief-v1`.

### `hoc-plugin/`: plugin Claude Code tự làm
- Plugin để học cấu trúc plugin, gồm skill `new-project` (`/hoc-plugin:new-project <tên> <mô tả>`) và hook `SessionStart` (`hooks/session-start.sh`) in tóm tắt repo, cùng hook `Stop` (`hooks/stop-remind-commit.sh`) nhắc khi còn file chưa commit. Cả hai hook chỉ chạy khi remote `origin` chứa `hoc-claude-code`.
- Marketplace nằm ở `.claude-plugin/marketplace.json` ở gốc repo (tên `hoc-claude-code`). Cài bằng `claude plugin marketplace add ./` rồi `claude plugin install hoc-plugin@hoc-claude-code`.
- Kiểm tra sau khi sửa: `claude plugin validate .` (marketplace), `claude plugin validate hoc-plugin`, và `claude --plugin-dir ./hoc-plugin plugin details hoc-plugin`.
- Khi sửa plugin thì tăng `version` ở cả `plugin.json` lẫn `marketplace.json`, vì người đã cài chỉ nhận bản cập nhật khi số phiên bản đổi.

### `portfolio/`: trang cá nhân (digital CV)
- Một file `index.html` duy nhất, cùng bảng màu với `todo/`. Chạy bằng `open portfolio/index.html`. Khi push sẽ lên https://ngqacuongg.github.io/hoc-claude-code/portfolio/
- Giao diện lấy cảm hứng bố cục (không chép chữ hay thương hiệu) từ phongtdt-portfolio.cloud mà người dùng thích: nền tối là mặc định (`portfolio-theme` trống thì dùng `dark`), lưới chấm mờ, tiêu đề mở đầu 3 dòng chữ in hoa đậm (`UI.mega`, dòng giữa màu nhấn), nhãn in hoa giãn chữ, ô số liệu (`ME.highlights`) và 3 thẻ vai trò (`ME.roles`). Màu nhấn xanh rêu và mạng nơ-ron là dấu ấn riêng, giữ nguyên.
- Nội dung lấy từ CV (`~/Downloads/[NTU Application]/NQACuong_CV.pdf`) và các artifact trên claude.ai. Toàn bộ nằm trong object `ME` ở đầu thẻ `<script>`; mỗi đoạn chữ viết dạng `["tiếng Việt", "English"]`. Thứ tự chương nằm trong `CHAPTERS`.
- Chương "Mình là ai" (`ME.bioLead`, `ME.story`, `ME.goal`) viết lại từ bản tự thuật `~/Downloads/[NTU Application]/NQACuong_Autobiography_and_Research_Plan.pdf`. Không nêu tên trường hay giáo sư đang nộp hồ sơ lên trang.
- Chương "Hành trình" là timeline ngang (`ME.journey`), chỉ gồm học vấn, thực tập (BV Bệnh Nhiệt đới, ĐH Y Dược, Touching Soul Center) và trợ lý nghiên cứu (đồng thời ở BV Quân y 175 và BV Bệnh Nhiệt đới); mốc có `now: true` được chọn sẵn. Hoạt động ngoại khoá nằm ở `ME.alongside`.
- Chương "Nghiên cứu": 4 câu hỏi (`ME.interests`), rồi một lưới "Dự án & poster" dùng chung kiểu thẻ (`projectCard`) cho brochure Dinh dưỡng (`ME.nutrition`, kết khoá thực tập TSC) và các poster (`ME.posters`). Người dùng muốn hai loại này nằm chung, không tách thành khối riêng.
  - Mỗi mục có `thumb` (ảnh nhỏ trên thẻ) và `img` (ảnh nét, mở khi bấm). Mục chỉ có `thumb` thì thẻ không bấm được. Ảnh nằm ở `portfolio/img/`, xuất từ Canva của người dùng; **không dán link `canva.link` lên trang vì đó là link chỉnh sửa**.
  - Bấm thẻ brochure mở cửa sổ sách lật (`openBook`, `bookHTML`, `flipBook`): hai ảnh mặt giấy được cắt bằng CSS thành 8 trang theo `ME.nutrition.pages` (bìa trước, tài liệu tham khảo cuối); lật quá trang cuối thì hiện cả mặt ngoài và mặt trong.
  - Cả 5 poster đã có ảnh nét. Poster CHRO và hiPSC lấy từ ảnh người dùng dán vào chat (1414 × 2000), vì Canva không cho xuất thiết kế của tài khoản khác.
- Chương "Dạy & chia sẻ" là tài liệu gia sư Sinh học lớp 10 cho một học sinh trường International German School (`ME.tutor`, hàm `tutorHTML`). Nguồn ở `~/Downloads/[TS]/Crystal - IGS/`; **không đưa tên học sinh lên trang** (tên thư mục và phiếu gốc có tên học sinh).
  - Xếp theo 13 stage K (Lernplan của trường), mỗi stage mở ra theo thứ tự Slides → Cheat sheet → Video → Phiếu bài tập. Tài liệu dùng chung nhiều stage ghi `ks: [từ, đến]`. Stage K có 3 phiếu: K1 = AB1–3 … K13 = AB37–39 (dòng "Topic block N" trong phiếu xác nhận điều này).
  - Mỗi K có một dòng "Tương tác" trỏ tới visual tương tác: `portfolio/lessons/genetics-k1-k4.html` và `genetics-k5-k13.html`, là bản sao của hai artifact bài học trên claude.ai (Genetics Stage 1, Stage 2), mở thẳng phần `#kN`. Khi người dùng sửa artifact, đọc lại artifact rồi chép lại; bản sao đã được thêm link "← Portfolio", đoạn đồng bộ sáng/tối theo `portfolio-theme`, `scroll-margin-top` và đoạn cuộn tới `#kN` sau khi tải. **Bỏ khối "Kế hoạch … trước bài kiểm tra" có ngày cụ thể** (lịch riêng của học sinh) ở bản công khai.
  - 39 phiếu bài tập là bản người dùng dịch từ phiếu tiếng Đức của giáo viên, nên **chỉ hiện tên, không cho tải** (người dùng đã chọn vậy).
  - Slides, cheat sheet và video nằm trong `portfolio/media/`: slides là PDF xuất từ .pptx bằng PowerPoint, cheat sheet là PDF xuất từ .docx bằng Word (cả hai qua `osascript`, nên đặt `with timeout of 300 seconds` vì app khởi động chậm). Mỗi bộ K1–K4, K5–K7, K8–K10, K11–K13 có một slides, hai cheat sheet (Anh–Việt, Anh–Đức) và một video `genetics-kX-kY.mp4` kèm ảnh `-poster.jpg`. Video mở trong cửa sổ `#vidDlg`.
- Mục Liên hệ có hai email (`ME.emails`), người dùng đã đồng ý công khai.
- CV rút gọn công khai: `portfolio/cv/index.html` (tiếng Anh, khổ A4) và `portfolio/cv/NguyenQuocAnhCuong_CV.pdf`, mở từ nút "Xem CV" trên thanh điều hướng và nút ở mục Liên hệ. Cố ý **không có số điện thoại, GPA, người tham chiếu**. Sửa CV thì sửa HTML rồi xuất lại PDF (máy không có Chrome, dùng WebKit):
  `swiftc -O -o /tmp/html2pdf portfolio/cv/html2pdf.swift && /tmp/html2pdf "$PWD/portfolio/cv/index.html" "$PWD/portfolio/cv/NguyenQuocAnhCuong_CV.pdf"`
  Khi in, WebKit bỏ qua `break-after: avoid`, nên mục Poster được ép sang trang 2 bằng lớp `page-break`; bố cục điện thoại chỉ áp dụng cho `@media screen`. Xuất xong phải xem lại số trang (đang là 2).
- Ngoại lệ duy nhất về thư viện ngoài: font Lora và Be Vietnam Pro từ Google Fonts, vì font hệ thống kiểu Iowan/Georgia hiện sai dấu chữ ư, ơ.
- Trang công khai: không đưa số điện thoại, GPA hay liên hệ người tham chiếu trong CV lên nếu người dùng chưa đồng ý. Link artifact claude.ai mặc định là riêng tư, người xem chỉ mở được khi người dùng đã bật chia sẻ.
- Chương "Học code" (`ME.school`, `ME.build`) gọi GitHub API công khai lúc mở trang (`loadGitHub`) để lấy thời gian push của từng repo và 6 commit mới nhất của repo này, nên push xong là trang tự mới. Kết quả lưu tạm 30 phút ở khoá `portfolio-gh` vì API giới hạn 60 lần/giờ cho mỗi người xem. Repo môn học hay dự án mới thì thêm tay vào `ME.school` / `ME.build`.
- `localStorage`: khoá `portfolio-theme` (sáng/tối), `portfolio-lang` (vi/en) và `portfolio-gh` (bộ đệm GitHub).

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
- **`find-skills`** (https://github.com/vercel-labs/skills): tìm và gợi ý skill trên https://skills.sh/ khi người dùng hỏi "có skill nào cho X không".
  - Cài ở `~/.claude/skills/find-skills` bằng cách chép tay `SKILL.md` (máy chưa có Node nên không chạy được `npx skills add`).
  - Skill gọi `npx skills find ...`, nên cần cài Node.js thì mới tìm kiếm được; khi chưa có Node, chỉ xem được bảng xếp hạng trên skills.sh.
- **`graphify`** (https://github.com/Graphify-Labs/graphify, Apache-2.0): biến một thư mục (code, tài liệu, PDF, ảnh) thành knowledge graph để hỏi đáp thay vì grep. Gọi bằng `/graphify .`; dòng lệnh có `graphify query "<câu hỏi>"`, `graphify path A B`, `graphify explain X`.
  - Cần CLI `graphify` (gói Python `graphifyy`, Python ≥ 3.10). Máy chỉ có Python 3.9 nên cài qua `uv` (`~/.local/bin/uv`, uv tự quản Python riêng): `uv tool install "graphifyy[pdf]"` (phần `[pdf]` thêm `pypdf` để đọc file PDF), rồi `graphify install` ghi skill vào `~/.claude/skills/graphify` và thêm một đoạn vào `~/.claude/CLAUDE.md`.
  - Cập nhật: `uv tool upgrade graphifyy && graphify install`. Gỡ: `graphify uninstall` rồi `uv tool uninstall graphifyy`.
  - Phần code phân tích tại máy (tree-sitter, không dùng LLM). Kết quả nằm ở `graphify-out/` (`graph.html`, `GRAPH_REPORT.md`, `graph.json`); nếu chạy trong repo này thì thêm `graphify-out/` vào `.gitignore` hoặc chấp nhận nó lên Pages.
- **`agent-skills`** (https://github.com/addyosmani/agent-skills, MIT): plugin gồm 25 skill quy trình làm phần mềm (spec, chia việc, TDD, review, debug, bảo mật, ship), lệnh `/spec`, `/plan`, `/build`, `/test`, `/review`, `/code-simplify`, `/ship`, `/webperf`, `/constraints`, và 4 agent (code-reviewer, security-auditor, test-engineer, web-performance-auditor).
  - Cài bằng `claude plugin marketplace add addyosmani/agent-skills` rồi `claude plugin install agent-skills@addy-agent-skills` (cấp người dùng). Cập nhật: `claude plugin marketplace update addy-agent-skills`.
  - Các script trong `hooks/` của repo không được `plugin.json` đăng ký nên không tự chạy.
- **`ponytail`** (https://github.com/DietrichGebert/ponytail): hiện chỉ có skill chính, đồng bộ từ claude.ai (`anthropic-skills:ponytail`). Bản plugin đầy đủ có thêm skill phụ và hook viết bằng Node, nên chưa cài vì máy chưa có Node.

## Hướng dẫn và bộ nhớ từ claude.ai

<!-- Claude Code không đọc được trực tiếp custom instructions hoặc memory của claude.ai chat.
     Hãy dán nội dung đó vào mục này. -->
