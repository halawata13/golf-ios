import Foundation
import UIKit

class ViewController: UIViewController {

    var playMatView: PlayMatView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        title = "Golf"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(onTapRestart))

        start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// リスタートボタン
    func onTapRestart() {
        start()
    }

    /// ゲーム開始
    func start() {
        if let playMatView = playMatView {
            playMatView.removeFromSuperview()
        }

        playMatView = PlayMatView()
        view.addSubview(playMatView!)
    }
}
