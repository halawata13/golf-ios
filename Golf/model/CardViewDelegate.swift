import Foundation

protocol CardViewDelegate: class {

    func touchesBegan(view: CardView)

    func touchesMoved(view: CardView)

    func touchesCancelled(view: CardView)

    func touchesEnded(view: CardView)
}
