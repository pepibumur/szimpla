import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request(url: NSURL(string: "http://analytics.com/")!, parameters: ["screen": "second"])
    }
    
}

