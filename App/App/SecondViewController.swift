import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        request(url: NSURL(string: "https://analytics.com/")!, parameters: ["screen": "second"])
    }
    
}

