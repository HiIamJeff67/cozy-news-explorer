import SwiftUI
import WebKit

enum MusicNavigationPath {
    case original, lyrics
}

struct MusicView: View {
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @EnvironmentObject private var theme : ThemeManager
    @EnvironmentObject private var player: PlayerStore
    
    @State private var songs: [SongModel] = Storage.Lofi_Study_Songs + Storage.TOGENASHI_TOGEARI_Songs
    @State private var path: [MusicNavigationPath] = []
    
    func handleMusicCardOnClick(song: SongModel) -> Void {
        if song.lyrics != nil {
            path.append(MusicNavigationPath.lyrics)
        }
        player.play(song)
    }

    var body: some View {
        NavigationStack (path: $path) {
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 16) {
                    ForEach(songs) { song in
                        SongCardView(
                            song: song,
                            isSelected: song == player.current,
                            isCurrent: song == player.current,
                            isPlaying: player.isPlaying
                        )
                        .modifier(SongCardViewModifier(song: song, handleOnClick: handleMusicCardOnClick))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
            .toolbar {
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
            .toolbarColorScheme(theme.isDark ? .dark : .light, for: .navigationBar)
            .toolbarBackground(theme.isDark ? .black.opacity(0.3) : .white.opacity(0.3), for: .navigationBar)
            .navigationTitle("音樂播放清單")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: MusicNavigationPath.self) { value in
                if value == MusicNavigationPath.lyrics {
                    LyricsView(path: $path)
                }
            }
        }
        .preferredColorScheme(theme.preference.colorScheme)
        .animation(.spring(response: 0.35, dampingFraction: 0.85), value: player.current?.id)
    }
    
    private var gridColumns: [GridItem] {
        let count: Int
        #if os(iOS)
        count = (hSizeClass == .regular) ? 3 : 2
        #else
        count = 3
        #endif
        return Array(repeating: GridItem(.flexible(), spacing: 16), count: count)
    }
}

