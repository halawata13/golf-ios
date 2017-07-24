import Foundation

class Card {

    let suit: PlayingCard.Suit
    let number: UInt

    var column: Int?
    var row: Int?

    var imageName: String {
        return suit.rawValue + String(number)
    }

    init?(suit: PlayingCard.Suit, number: UInt?) {
        switch suit {
        case .spade:
            fallthrough
        case .club:
            fallthrough
        case .heart:
            fallthrough
        case .diamond:
            guard let number = number else {
                return nil
            }

            if number == 0 || number > 13 {
                return nil
            }

            self.suit = suit
            self.number = number
        case .joker:
            self.suit = .joker
            self.number = 0
        }
    }
}
