import Foundation
import UIKit

class Tutorial2ViewController: UIViewController {

    @IBAction func onTapSkip(_ sender: UIButton) {
        (parent as? TutorialPageViewController)?.end()
    }
}
