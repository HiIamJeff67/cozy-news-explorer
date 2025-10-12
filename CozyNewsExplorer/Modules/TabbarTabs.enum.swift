import Foundation

enum TabbarTabs: CaseIterable, Identifiable, Hashable {
    case Home
    case News
    case Music

    var id: Self { self }

    var name: String {
        switch self {
        case .Home:
            "主頁"
        case .News:
            "新聞"
        case .Music:
            "音樂"
        }
    }

    var symbol: String {
        switch self {
        case .Home:
            "house"
        case .News:
            "newspaper"
        case .Music:
            "music.note.square.stack"
        }
    }
}

