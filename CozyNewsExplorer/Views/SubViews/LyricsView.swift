import SwiftUI

struct LyricsView : View {
    @EnvironmentObject private var theme: ThemeManager
    @EnvironmentObject private var player: PlayerStore
    
    @Binding var path: [MusicNavigationPath]
    
    var body : some View {
        ScrollView {
            HTMLText(html: player.current?.lyrics ?? "Lyrics Not Found", textColor: theme.isDark ? .white : .black)
                .modifier(LyricsModifier())
        }
        .navigationTitle("歌詞")
    }
}
    
