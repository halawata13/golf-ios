import Foundation

class PlayingCard {

    var deck = [Card]()

    static let suits: [Suit] = [
        .spade,
        .club,
        .heart,
        .diamond,
    ]

    init(joker: UInt = 0) {
        PlayingCard.suits.forEach { (suit) in
            for i: UInt in 1...13 {
                deck.append(Card(suit: suit, number: i)!)
            }
        }

        for _ in 0..<joker {
            deck.append(Card(suit: .joker, number: 0)!)
        }
    }

    /// デッキをシャッフルする
    func shuffle() {
        deck = deck.shuffled()
    }

    /// 2つのカードが連番になっているか
    static func isPassing(_ a: Card, and b: Card) -> Bool {
        if a.number == b.number + 1 || a.number == b.number - 1 {
            return true
        }

        if (a.number == 1 && b.number == 13) || (a.number == 13 && b.number == 1) {
            return true
        }

        return false
    }

    enum Suit: String {
        case spade = "spade"
        case club = "club"
        case heart = "heart"
        case diamond = "diamond"
        case joker = "joker"
    }
}
