import Foundation
import WebKit

class WebViewModel {
    
    var webView: WKWebView?
    
    func loadUrl(url: URL) {
        let request = URLRequest(url: url)
        webView?.load(request)
    }
    
}
