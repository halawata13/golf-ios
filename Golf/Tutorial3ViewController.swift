import Foundation
import UIKit

class Tutorial3ViewController: UIViewController {

    @IBAction func onTapStart(_ sender: UIButton) {
        (parent as? TutorialPageViewController)?.end()
    }
}
