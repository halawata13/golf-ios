import Foundation

protocol ConfigItem: class {

    static var title: String { get }
    static var defaultNumber: Int { get }

    var min: Int { get }
    var max: Int { get }
    var number: Int { get set }
    var isMax: Bool { get }
    var isMin: Bool { get }

    static func get() -> Int

    func plus()
    func minus()
}

extension ConfigItem {

    func plus() {
        if number == max {
            return
        }

        number += 1
    }

    func minus() {
        if number == min {
            return
        }

        number -= 1
    }
}
