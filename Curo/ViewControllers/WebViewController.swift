import UIKit
import WebKit

class WebViewController: UIViewController {

    var viewModel: WebViewModel
    var homepageURL: URL?

    init(viewModel: WebViewModel, homepageURL: URL?) {
        self.viewModel = viewModel
        self.homepageURL = homepageURL
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupWebView()
        loadHomepage()
    }

    func setupWebView() {
        let webView = WKWebView(frame: view.frame)
        view.addSubview(webView)
        self.viewModel.webView = webView
    }

    func loadHomepage() {
        guard let url = homepageURL else {
            print("Error: No URL found in notes")
            return
        }

        viewModel.loadUrl(url: url)
    }

}
