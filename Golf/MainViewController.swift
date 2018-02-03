import Foundation
import UIKit

class MainViewController: UIViewController {

    var playMatView: PlayMatView?
    var gameResultView: GameResultView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        title = "Golf"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(onTapRestart))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "設定", style: .plain, target: self, action: #selector(onTapConfig))

        if !UserDefaults.standard.bool(forKey: "initial") {
            present(storyboard!.instantiateViewController(withIdentifier: "TutorialPageViewController"), animated: false)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        start()

        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// リスタートボタン
    @objc func onTapRestart() {
        start()
    }

    /// 設定ボタン
    @objc func onTapConfig() {
        guard let configNavigationController = storyboard?.instantiateViewController(withIdentifier: "ConfigNavigationController") else {
            assertionFailure()
            return
        }

        configNavigationController.modalTransitionStyle = .crossDissolve
        present(configNavigationController, animated: true)
    }

    /// ゲーム開始
    func start() {
        if let playMatView = playMatView {
            playMatView.removeFromSuperview()
        }

        if let gameResultView = gameResultView {
            gameResultView.removeFromSuperview()
        }

        playMatView = PlayMatView()
        playMatView!.delegate = self
        view.addSubview(playMatView!)
    }
}

extension MainViewController: PlayMatViewDelegate {

    func gameClear() {
        gameResultView = GameResultView(frame: view.frame)
        view.addSubview(gameResultView!)
    }
}
