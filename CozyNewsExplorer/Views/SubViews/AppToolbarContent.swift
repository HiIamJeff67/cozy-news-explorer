import SwiftUI

struct AppToolbarContent: ToolbarContent {
    @EnvironmentObject private var theme: ThemeManager

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: goToMyGithub) {
                Image(systemName: "heart.fill")
                Text("Buy me a coffee !")
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: theme.toggle) {
                Image(systemName: theme.isDark ? "sun.max.fill" : "moon.fill")
                    .font(.title3)
                    .foregroundStyle(theme.isDark ? .orange : .blue)
                    .symbolEffect(.bounce, value: theme.isDark)
            }
            .background(.ultraThinMaterial)
            .clipShape(Circle())
        }
    }
}
