import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var theme: ThemeManager
    @EnvironmentObject private var player: PlayerStore
    
    var body: some View {
        VStack {
            ZStack {
                TabView {
                    MusicView()
                        .tabItem {
                            Label(TabbarTabs.Music.name, systemImage: TabbarTabs.Music.symbol)
                        }
                    NewsView()
                        .tabItem {
                            Label(TabbarTabs.News.name, systemImage: TabbarTabs.News.symbol)
                        }
                }
                .tabViewStyle(.sidebarAdaptable)
                .preferredColorScheme(theme.preference.colorScheme)
            }
            .overlay(alignment: .bottom) {
                if player.current != nil {
                    MiniPlayerView()
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: player.current != nil)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
        .environmentObject(PlayerStore())
}
