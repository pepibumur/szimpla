import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        request(url: NSURL(string: "http://analytics.com/")!, parameters: ["screen": "second"])
    }
    
}

