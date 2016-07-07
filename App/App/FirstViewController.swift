import UIKit

class FirstViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        request(url: NSURL(string: "https://analytics.com/")!, parameters: ["screen": "first"])
    }
}

