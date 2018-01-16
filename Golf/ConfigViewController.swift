import Foundation
import UIKit

class ConfigViewController: UIViewController {

    let dataSource = ConfigTableViewDataSource()

    @IBOutlet weak var configTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "設定"

        configTableView.dataSource = dataSource

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
    }

    @objc func onDone() {
        navigationController?.dismiss(animated: true)
    }
}
