import Foundation

class Row: ConfigItem {

    static let title = "行の数"
    static let defaultNumber = 7

    let min = 1
    let max = 8

    var number: Int {
        didSet {
            if number < min || number > max {
                number = Row.defaultNumber
            }

            UserDefaults.standard.set(number, forKey: String(describing: type(of: Row.self)))
        }
    }

    var isMax: Bool {
        return number == max
    }

    var isMin: Bool {
        return number == min
    }

    init() {
        self.number = Row.get()
    }

    static func get() -> Int {
        let number = UserDefaults.standard.integer(forKey: String(describing: type(of: Row.self)))
        return number != 0 ? number : Row.defaultNumber
    }
}
