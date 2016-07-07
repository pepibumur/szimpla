import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - Attributes
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.title = "NSSpain 💃"
        self.imageView.image = UIImage(named: "Marcheta.JPG")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // TODO
    }
    
}

