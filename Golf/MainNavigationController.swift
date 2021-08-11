import Foundation
import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.barTintColor = UIColor(red: 140 / 255, green: 0, blue: 0, alpha: 1)
        toolbar.tintColor = UIColor.white
    }
}
