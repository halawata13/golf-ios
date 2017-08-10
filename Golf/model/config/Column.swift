import Foundation

class Column: ConfigItem {

    static let title = "列の数"

    static let min = 1
    static let max = 6

    static let defaultNumber = 5

    var number: Int {
        didSet {
            if number < Column.min || number > Column.max {
                number = Column.defaultNumber
            }

            UserDefaults.standard.set(number, forKey: String(describing: type(of: Column.self)))
        }
    }

    init() {
        self.number = Column.get()
    }

    static func get() -> Int {
        let number = UserDefaults.standard.integer(forKey: String(describing: type(of: Column.self)))
        return number != 0 ? number : Column.defaultNumber
    }
}
