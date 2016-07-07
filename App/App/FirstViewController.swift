import UIKit

class FirstViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CMD+U Conf🌴"
    }
    
    @IBAction func userDidSelectMarcheta(sender: AnyObject) {
        self.performSegueWithIdentifier("push", sender: nil)
        // TODO
    }

}

