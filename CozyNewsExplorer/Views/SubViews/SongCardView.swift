import SwiftUI

struct SongCardView : View {
    let song: SongModel
    let isSelected: Bool
    let isCurrent: Bool
    let isPlaying: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                cover
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                
                if isCurrent {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: isPlaying ? "waveform.circle.fill" : "pause.circle.fill")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(.white)
                                .shadow(radius: 6)
                        }
                        .padding(10)
                        Spacer()
                    }
                }
                
                VStack {
                    Spacer()
                    LinearGradient(
                        colors: [Color.black.opacity(0.0), Color.black.opacity(0.55)],
                        startPoint: .top, endPoint: .bottom
                    )
                    .frame(height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(alignment: .bottomLeading) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(song.title)
                                .modifier(CardTitleModifier())
                            Text(song.artist)
                                .modifier(CardArtistModifier())
                        }
                        .padding(.horizontal, 12)
                        .padding(.bottom, 10)
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(isSelected ? Color.blue.opacity(0.6) : Color.clear, lineWidth: 2)
            )
            .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
        }
        .contentShape(Rectangle())
    }
    
    @ViewBuilder
    private var cover: some View {
        if let urlString = song.imageURL, let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        placeholder
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    placeholder
                @unknown default:
                    placeholder
                }
            }
        } else {
            placeholder
        }
    }
    
    private var placeholder: some View {
        ZStack {
            LinearGradient(
                colors: [Color.gray.opacity(0.25), Color.gray.opacity(0.15)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            Image(systemName: "music.note")
                .font(.system(size: 36))
                .foregroundStyle(.secondary)
        }
    }
}
