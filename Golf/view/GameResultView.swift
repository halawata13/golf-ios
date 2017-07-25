import Foundation
import UIKit

class GameResultView: UIView {

    @IBOutlet weak var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadXib()
    }

    private func loadXib() {
        Bundle.main.loadNibNamed("GameResultView", owner: self)
        contentView.frame = bounds
        addSubview(contentView)
    }
}
