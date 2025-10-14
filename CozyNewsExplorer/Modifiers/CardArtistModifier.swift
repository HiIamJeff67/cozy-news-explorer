import SwiftUI

struct CardArtistModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundStyle(.white.opacity(0.8))
            .lineLimit(1)
    }
}
