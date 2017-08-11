import Foundation

class Row: ConfigItem {

    static let title = "行の数"

    static let min = 1
    static let max = 8

    static let defaultNumber = 7

    var number: Int {
        didSet {
            if number < Row.min || number > Row.max {
                number = Row.defaultNumber
            }

            UserDefaults.standard.set(number, forKey: String(describing: type(of: Row.self)))
        }
    }

    var isMax: Bool {
        return number == Row.max
    }

    var isMin: Bool {
        return number == Row.min
    }

    init() {
        self.number = Row.get()
    }

    static func get() -> Int {
        let number = UserDefaults.standard.integer(forKey: String(describing: type(of: Row.self)))
        return number != 0 ? number : Row.defaultNumber
    }
}
