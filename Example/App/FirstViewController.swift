import UIKit

class FirstViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request(url: NSURL(string: "http://analytics.com/")!, parameters: ["screen": "first"])
    }

}

