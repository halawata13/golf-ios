import Foundation
import UIKit

class PlayMatView: UIView {

    static let cardWidth = 100
    static let gutterWidth = 40
    static let startY = 100
    static let overlapHeight = 30
    static let deckX = 700
    static let stageY = 510

    let columns: Int
    let rows: Int

    var delegate: PlayMatViewDelegate?

    fileprivate var targets = [[CardView]]()
    fileprivate var deck = [Card]()
    fileprivate var stageCardView: CardView!
    fileprivate var deckCardView: UIImageView!

    override init(frame: CGRect) {
        // 設定を取得
        columns = Column.get()
        rows = Row.get()

        super.init(frame: frame)

        // カードを取得してデッキにセット
        let playingCard = PlayingCard()
        playingCard.shuffle()

        deck = playingCard.deck

        // デッキから場札を配置
        let totalCatdWidth = PlayMatView.cardWidth * columns
        let totalMarginWidth = PlayMatView.gutterWidth * (columns - 1)
        let startX = (Int(frame.width) - totalCatdWidth - totalMarginWidth) / 2

        for i in 0..<columns {
            var column = [CardView]()

            for j in 0..<rows {
                guard let card = deck.popLast() else {
                    fatalError("Too few cards.")
                }

                card.column = i
                card.row = j

                let cardView = CardView(card: card)
                cardView.isUserInteractionEnabled = false
                cardView.frame.origin = CGPoint(x: startX + (PlayMatView.cardWidth + PlayMatView.gutterWidth) * i, y: PlayMatView.startY + PlayMatView.overlapHeight * j)
                addSubview(cardView)

                column.append(cardView)
            }

            targets.append(column)
        }

        // デッキから手札を配置
        guard let stageCard = deck.popLast() else {
            fatalError("Too few cards.")
        }

        stageCardView = CardView(card: stageCard)
        stageCardView.frame.origin = CGPoint(x: frame.width / 2 - stageCardView.frame.width / 2, y: CGFloat(PlayMatView.stageY))
        addSubview(stageCardView)

        // デッキを配置
        deckCardView = UIImageView(image: UIImage(named: "back"))
        deckCardView.isUserInteractionEnabled = true
        deckCardView.frame.origin = CGPoint(x: PlayMatView.deckX, y: PlayMatView.stageY)

        let tapRestsCardsRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapRestsCard))
        deckCardView.addGestureRecognizer(tapRestsCardsRecognizer)
        addSubview(deckCardView)

        // 操作可能カードを設定
        setUserInteractionEnabled()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }

    func onTapRestsCard(_ recognizer: UITapGestureRecognizer) {
        guard let card = deck.last else {
            return
        }

        // 残り一枚の状態で引いたらデッキのビューを消す
        if deck.count == 1 {
            deckCardView.removeFromSuperview()
        }

        // カードをめくるアニメーション
        let animationCardView1 = UIImageView(image: UIImage(named: "back"))
        animationCardView1.frame.origin = CGPoint(x: deckCardView.frame.origin.x, y: deckCardView.frame.origin.y)

        let animationCardView2 = CardView(card: card)
        animationCardView2.imageView.frame.size = CGSize(width: 0, height: animationCardView2.frame.height)
        animationCardView2.frame.origin = CGPoint(x: (deckCardView.frame.origin.x + stageCardView.frame.origin.x) / 2, y: deckCardView.frame.origin.y)

        // カードが表を向くまで
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let deckCardView = self?.deckCardView,
                  let stageCardView = self?.stageCardView else {
                return
            }

            self?.addSubview(animationCardView1)
            animationCardView1.frame = CGRect(x: (deckCardView.frame.origin.x + stageCardView.frame.origin.x) / 2, y: stageCardView.frame.origin.y, width: 0, height: deckCardView.frame.size.height)

        }, completion: { _ in
            animationCardView1.removeFromSuperview()
        })

        // カードが表を向いた後
        UIView.animate(withDuration: 0.2, delay: 0.2, options: [.curveEaseOut], animations: { [weak self] in
            guard let stageCardView = self?.stageCardView else {
                return
            }

            self?.addSubview(animationCardView2)
            animationCardView2.imageView.frame.size = CGSize(width: stageCardView.frame.width, height: animationCardView2.frame.height)
            animationCardView2.frame.origin = CGPoint(x: stageCardView.frame.origin.x, y: stageCardView.frame.origin.y)

        }, completion: { [weak self] _ in
            animationCardView2.removeFromSuperview()
            self?.drawFromDeck()
        })
    }

    /// デッキからカードを手札に
    func drawFromDeck() {
        if let card = deck.popLast() {
            stageCardView.change(card: card)

            if deck.isEmpty {
                deckCardView.removeFromSuperview()
            }
        }
    }

    /// 操作可能カードを設定
    func setUserInteractionEnabled() {
        // 場札の最後のカードを操作可能に
        targets.forEach { (column) in
            guard let lastCardView = column.last else {
                return
            }

            let tapLastCardRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapLastCard))

            if lastCardView.isUserInteractionEnabled == false {
                lastCardView.delegate = self
                lastCardView.isUserInteractionEnabled = true

                lastCardView.addGestureRecognizer(tapLastCardRecognizer)
            }
        }

        // 手札は動かない
        stageCardView.isUserInteractionEnabled = false
    }

    /// 場札の最後のカードのタップ時
    func tapLastCard(_ recognizer: UITapGestureRecognizer) {
        guard let view = recognizer.view as? CardView else {
            assertionFailure()
            return
        }

        if PlayingCard.isPassing(view.card, and: stageCardView.card) {
            view.moveTo(stageCardView.frame.origin)
            self.stageCardView = targets[view.card.column!].popLast()!

            // 操作可能カードを設定
            setUserInteractionEnabled()

            // ゲームクリアチェック
            let _ = isGameClear()
        } else {
            view.moveToPrevious()
        }
    }

    /// 場札がなくなってゲームクリアしているか
    func isGameClear() -> Bool {
        for column in targets {
            if column.isEmpty == false {
                return false
            }
        }

        delegate?.gameClear()
        return true
    }
}

extension PlayMatView: CardViewDelegate {

    /// 移動開始
    func touchesBegan(view: CardView) {
        bringSubview(toFront: view)
    }

    /// 移動中
    func touchesMoved(view: CardView) {
        if view.frame.intersects(stageCardView.frame),
           PlayingCard.isPassing(view.card, and: stageCardView.card) {
            view.addShadow()
        } else {
            view.removeShadow()
        }
    }

    /// 移動キャンセル
    func touchesCancelled(view: CardView) {
    }

    /// 移動終了
    func touchesEnded(view: CardView) {
        if view.frame.intersects(stageCardView.frame),
           PlayingCard.isPassing(view.card, and: stageCardView.card) {
            // 手札と連番ならその場札を手札へ
            view.moveTo(stageCardView.frame.origin)
            self.stageCardView = targets[view.card.column!].popLast()!

            // 操作可能カードを設定
            setUserInteractionEnabled()

            // ゲームクリアチェック
            let _ = isGameClear()
        } else {
            view.moveToPrevious()
        }

        view.removeShadow()
    }
}
