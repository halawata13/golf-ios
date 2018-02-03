import Foundation

class Column: ConfigItem {

    static let title = "列の数"
    static let defaultNumber = 5

    let min = 1
    let max = 6

    var number: Int {
        didSet {
            if number < min || number > max {
                number = Column.defaultNumber
            }

            UserDefaults.standard.set(number, forKey: String(describing: type(of: Column.self)))
        }
    }

    var isMax: Bool {
        return number == max
    }

    var isMin: Bool {
        return number == min
    }

    init() {
        self.number = Column.get()
    }

    static func get() -> Int {
        let number = UserDefaults.standard.integer(forKey: String(describing: type(of: Column.self)))
        return number != 0 ? number : Column.defaultNumber
    }
}
