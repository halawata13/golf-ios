import Foundation

class Config {

    static let titleList = [
        Column.title,
        Row.title,
    ]

    static func getItem(title: String) -> ConfigItem? {
        switch title {
        case Column.title:
            return Column()
        case Row.title:
            return Row()
        default:
            return nil
        }
    }
}
