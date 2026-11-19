import AppKit
import WebKit
// Mở một trang HTML bằng WebKit rồi in ra PDF khổ A4 (có chia trang), không cần trình duyệt.
let src = URL(fileURLWithPath: CommandLine.arguments[1]); let out = URL(fileURLWithPath: CommandLine.arguments[2])
class D: NSObject, WKNavigationDelegate {
  let wv = WKWebView(frame: NSRect(x: 0, y: 0, width: 794, height: 1123))
  func start() { wv.navigationDelegate = self; wv.loadFileURL(src, allowingReadAccessTo: src.deletingLastPathComponent()) }
  func webView(_ w: WKWebView, didFinish n: WKNavigation!) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {   // đợi web font tải xong
      let pi = NSPrintInfo.shared.copy() as! NSPrintInfo
      pi.paperSize = NSSize(width: 595.28, height: 841.89)
      pi.topMargin = 0; pi.bottomMargin = 0; pi.leftMargin = 0; pi.rightMargin = 0
      pi.horizontalPagination = .fit; pi.verticalPagination = .automatic
      pi.jobDisposition = .save
      pi.dictionary()[NSPrintInfo.AttributeKey.jobSavingURL] = out
      let op = w.printOperation(with: pi); op.showsPrintPanel = false; op.showsProgressPanel = false
      op.view?.frame = NSRect(x: 0, y: 0, width: 595.28, height: 841.89)
      op.runModal(for: NSWindow(), delegate: self, didRun: #selector(self.done(_:success:contextInfo:)), contextInfo: nil)
    }
  }
  @objc func done(_ op: NSPrintOperation, success: Bool, contextInfo: UnsafeMutableRawPointer?) { print("printed:", success); exit(success ? 0 : 1) }
}
let app = NSApplication.shared; app.setActivationPolicy(.prohibited)
let d = D(); d.start()
DispatchQueue.main.asyncAfter(deadline: .now() + 60) { print("timeout"); exit(2) }
app.run()
