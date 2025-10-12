import SwiftUI

struct SongCardViewModifier : ViewModifier {
    @EnvironmentObject private var player: PlayerStore
    
    let song: SongModel
    let handleOnClick: (SongModel) -> Void
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                    handleOnClick(song)
                }
            }
            .contextMenu {
                Button {
                    withAnimation(.spring) {
                        handleOnClick(song)
                    }
                } label: {
                    Label("播放", systemImage: "play.fill")
                }
                Button {
                    if let url = URL(string: song.imageURL ?? "") {
                        UIPasteboard.general.url = url
                    } else {
                        UIPasteboard.general.string = song.openInSpotifyURL.absoluteString
                    }
                } label: {
                    Label("複製連結/封面 URL", systemImage: "link")
                }
                Link(destination: song.openInSpotifyURL) {
                    Label("在 Spotify 開啟", systemImage: "music.note")
                }
            }
    }
}
