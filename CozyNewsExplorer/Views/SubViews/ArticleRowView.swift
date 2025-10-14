import SwiftUI

struct ArticleRowView: View {
    let article: Article

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let urlStr = article.urlToImage, let url = URL(string: urlStr) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2))
                    case .success(let img):
                        img.resizable().scaledToFill()
                    case .failure:
                        RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2))
                    @unknown default:
                        RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2))
                    }
                }
                .frame(width: 84, height: 84)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(article.title ?? "No title")
                    .font(.headline)
                    .lineLimit(2)
                Text(article.description ?? article.content ?? "No description")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)

                HStack {
                    Text(article.author ?? article.source?.name ?? "Unknown")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    if let urlStr = article.url, let url = URL(string: urlStr) {
                        Link("閱讀更多", destination: url)
                            .font(.caption)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}
