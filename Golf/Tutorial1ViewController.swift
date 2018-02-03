import Foundation
import UIKit

class Tutorial1ViewController: UIViewController {

    @IBAction func onTapSkip(_ sender: UIButton) {
        (parent as? TutorialPageViewController)?.end()
    }
}
