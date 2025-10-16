import SwiftUI
import Combine

@MainActor
final class NewsViewModel: ObservableObject {
    @Published var topHeadlines: [Article] = []
    @Published var allArticles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var client: NewsAPIClient?

    init() {
        do {
            self.client = try NewsAPIClient()
        } catch {
            self.errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            self.client = nil
        }
    }

    func loadInitial() async {
        guard let client = client else {
            if errorMessage == nil {
                errorMessage = "NewsAPI 尚未設定 API Key 或設定未套用。"
            }
            return
        }

        isLoading = true
        errorMessage = nil
        do {
            let headlines = try await client.searchTopHeadlines(country: "us", category: nil, pageSize: 10)
            self.topHeadlines = Array(headlines.prefix(10))
            let all = try await client.searchEverything(
                q: "technology",
                from: nil,
                to: nil,
                sortBy: "publishedAt",
                language: "en",
                pageSize: 30,
            )
            self.allArticles = all
        } catch {
            self.errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            self.topHeadlines = []
            self.allArticles = []
        }
        isLoading = false
    }

    func search(query: String) async {
        guard let client = client else {
            if errorMessage == nil {
                errorMessage = "NewsAPI 尚未設定 API Key 或設定未套用。"
            }
            return
        }
        guard query.isEmpty == false else { return }

        isLoading = true
        errorMessage = nil
        do {
            let result = try await client.searchEverything(
                q: query,
                from: nil,
                to: nil,
                sortBy: "publishedAt",
                language: "en",
                pageSize: 30,
            )
            self.allArticles = result
        } catch {
            self.errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }
}

