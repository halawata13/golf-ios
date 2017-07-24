import Foundation
import UIKit

class DraggableView: UIView {

    public var initialTouchLocation: CGPoint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        initialTouchLocation = touch.location(in: self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let initialTouchLocation = initialTouchLocation else {
            return
        }

        let location = touch.location(in: self)
        frame = frame.offsetBy(dx: location.x - initialTouchLocation.x, dy: location.y - initialTouchLocation.y)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let initialTouchLocation = initialTouchLocation else {
            return
        }

        let location = touch.location(in: self)
        frame = frame.offsetBy(dx: location.x - initialTouchLocation.x, dy: location.y - initialTouchLocation.y)
    }
}
