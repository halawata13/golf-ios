import Foundation

protocol ConfigItem: class {

    static var title: String { get }
    static var min: Int { get }
    static var max: Int { get }
    static var defaultNumber: Int { get }

    var number: Int { get set }

    static func get() -> Int

    func plus()
    func minus()
}

extension ConfigItem {

    func plus() {
        if number == Self.max {
            return
        }

        number += 1
    }

    func minus() {
        if number == Self.min {
            return
        }

        number -= 1
    }
}
