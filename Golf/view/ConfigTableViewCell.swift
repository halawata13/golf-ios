import Foundation
import UIKit

class ConfigTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!

    @IBAction func onTapPlusButton(_ sender: UIButton) {
        guard let title = titleLabel.text, let configItem = Config.getItem(title: title) else {
            assertionFailure()
            return
        }

        configItem.plus()

        numberLabel.text = String(configItem.number)
    }

    @IBAction func onTapMinusButton(_ sender: UIButton) {
        guard let title = titleLabel.text, let configItem = Config.getItem(title: title) else {
            assertionFailure()
            return
        }

        configItem.minus()

        numberLabel.text = String(configItem.number)
    }
}
