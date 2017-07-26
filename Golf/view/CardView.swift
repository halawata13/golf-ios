import Foundation
import UIKit

class CardView: DraggableView {

    var card: Card!
    var imageView: UIImageView!
    var prevLocation: CGPoint?

    weak var delegate: CardViewDelegate?

    convenience init(card: Card) {
        guard let image = UIImage(named: card.imageName) else {
            fatalError("Asset \(card.imageName) is not found.")
        }

        let imageView = UIImageView(image: image)

        self.init(frame: imageView.frame)

        self.card = card
        self.imageView = imageView
        addSubview(imageView)
    }

    /// 移動開始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        guard let cardView = touches.first?.view as? CardView else {
            return
        }

        prevLocation = frame.origin

        delegate?.touchesBegan(view: cardView)
    }

    /// 移動中
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        guard let cardView = touches.first?.view as? CardView else {
            return
        }

        delegate?.touchesMoved(view: cardView)
    }

    /// 移動キャンセル
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

        guard let cardView = touches.first?.view as? CardView else {
            return
        }

        delegate?.touchesCancelled(view: cardView)
    }

    /// 移動終了
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        guard let cardView = touches.first?.view as? CardView else {
            return
        }

        delegate?.touchesEnded(view: cardView)
    }

    /// カードを変更
    func change(card: Card) {
        guard let image = UIImage(named: card.imageName) else {
            fatalError("Asset \(card.imageName) is not found.")
        }

        self.card = card
        self.imageView.image = image
    }

    /// ドラッグ元の位置まで戻す
    func moveToPrevious() {
        guard let prevLocation = prevLocation else {
            return
        }

        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            self?.frame.origin = prevLocation
        })
    }

    /// 指定位置まで動かす
    func moveTo(_ point: CGPoint) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            self?.frame.origin = point
        })
    }

    /// 影をつける
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.green.cgColor
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }

    /// 影を消す
    func removeShadow() {
        layer.shadowOpacity = 0
    }
}
