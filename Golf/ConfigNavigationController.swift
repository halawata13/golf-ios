import Foundation
import UIKit

class ConfigNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.barTintColor = UIColor(red: 140 / 255, green: 0, blue: 0, alpha: 1)
        toolbar.tintColor = UIColor.white
    }
}
