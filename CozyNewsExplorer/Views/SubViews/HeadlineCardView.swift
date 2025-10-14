import SwiftUI

struct HeadlineCardView: View {
    let article: Article

    var body: some View {
        ZStack {
            // 背景圖片層：明確填滿並裁切，避免外擴
            if let urlStr = article.urlToImage, let url = URL(string: urlStr) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.2)
                    case .success(let img):
                        img
                            .resizable()
                            .scaledToFill()
                            .frame(width: 280, height: 160 ,alignment: .leading)
                            .clipped()
                    case .failure:
                        Color.gray.opacity(0.2)
                    @unknown default:
                        Color.gray.opacity(0.2)
                    }
                }
            } else {
                Color.gray.opacity(0.15)
            }

            LinearGradient(
                colors: [.black.opacity(0.0), .black.opacity(0.6)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .allowsHitTesting(false)

            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text(article.title ?? "No title")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .lineLimit(2)
                    Text(article.author ?? article.source?.name ?? "Unknown")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                        .lineLimit(1)
                }
                .padding(10)
            }
            .allowsHitTesting(false)
        }
        .compositingGroup()
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 6, y: 2)
        .overlay {
            if let urlStr = article.url, let url = URL(string: urlStr) {
                Link(destination: url) {
                    Color.clear
                }
            }
        }
        .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
