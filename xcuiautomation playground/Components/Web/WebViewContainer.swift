import SwiftUI
import WebKit

struct WebViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let htmlURL = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "Web") {
            webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL.deletingLastPathComponent())
        } else {
            let html = """
            <html>
            <head><meta name='viewport' content='initial-scale=1.0'/></head>
            <body>
            <h2>WebView Lab</h2>
            <form id='login'>
              <input type='text' id='email' placeholder='email' />
              <input type='password' id='password' placeholder='password' />
              <button type='button' onclick='alert("logged in")'>Login</button>
            </form>
            </body>
            </html>
            """
            webView.loadHTMLString(html, baseURL: nil)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }
}

struct WebViewLabScreen: View {
    var body: some View {
        WebViewContainer()
            .accessibilityIdentifier(AccessibilityIDs.webviewContainer)
            .navigationTitle("WebView Lab")
    }
}
