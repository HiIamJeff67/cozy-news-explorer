import SwiftUI

struct CardTitleModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.white)
            .lineLimit(1)
    }
}
