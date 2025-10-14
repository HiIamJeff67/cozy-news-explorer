import Foundation

struct NewsAPIResponse: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]
    let code: String?
    let message: String?
}

struct Article: Identifiable, Codable, Hashable {
    var id: String { url ?? UUID().uuidString }
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
}

struct Source: Codable, Hashable {
    let id: String?
    let name: String?
}
