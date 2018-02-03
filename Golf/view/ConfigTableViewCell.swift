import Foundation
import UIKit

class ConfigTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var valueStepper: UIStepper!

    @IBAction func onChangeValue(_ sender: UIStepper) {
        guard let title = titleLabel.text, let configItem = Config.getItem(title: title) else {
            assertionFailure()
            return
        }

        let value = Int(sender.value)

        numberLabel.text = String(value)
        configItem.number = value
    }
}
