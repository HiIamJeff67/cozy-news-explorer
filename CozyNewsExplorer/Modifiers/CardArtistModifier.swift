import SwiftUI

struct CardArtistModifier : ViewModifier {
    @EnvironmentObject private var theme: ThemeManager
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundStyle(theme.isDark ? .white.opacity(0.8) : .black.opacity(0.8))
            .lineLimit(1)
    }
}
