import SwiftUI

struct CardTitleModifier : ViewModifier {
    @EnvironmentObject private var theme: ThemeManager
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(theme.isDark ? .white : .black)
            .lineLimit(1)
    }
}
