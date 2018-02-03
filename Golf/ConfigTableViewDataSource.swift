import Foundation
import UIKit

class ConfigTableViewDataSource: NSObject, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Config.titleList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfigTableViewCell", for: indexPath) as! ConfigTableViewCell

        guard let configItem = Config.getItem(title: Config.titleList[indexPath.row]) else {
            assertionFailure()
            return cell
        }

        cell.valueStepper.maximumValue = Double(configItem.max)
        cell.valueStepper.minimumValue = Double(configItem.min)
        cell.valueStepper.value = Double(configItem.number)

        cell.titleLabel.text = Config.titleList[indexPath.row]
        cell.numberLabel.text = String(Int(cell.valueStepper.value))

        return cell
    }
}
