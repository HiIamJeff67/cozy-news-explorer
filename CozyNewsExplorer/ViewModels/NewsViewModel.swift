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
            // 讓 UI 能顯示明確錯誤，而不是靜默回傳空資料
            self.errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
            self.client = nil
        }
    }

    func loadInitial() async {
        // 如果 client 建立失敗（多半是缺 key），直接顯示錯誤
        guard let client = client else {
            if errorMessage == nil {
                errorMessage = "NewsAPI 尚未設定 API Key 或設定未套用。"
            }
            return
        }

        isLoading = true
        errorMessage = nil
        do {
            let headlines = try await client.topHeadlines(country: "us", category: nil, pageSize: 10)
            self.topHeadlines = Array(headlines.prefix(10))
            // 示範 everything 搜尋，可按需調整
            let all = try await client.searchEverything(query: "technology", pageSize: 30, sortBy: "publishedAt", language: "en")
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
            let result = try await client.searchEverything(query: query, pageSize: 30, sortBy: "publishedAt", language: "en")
            self.allArticles = result
        } catch {
            self.errorMessage = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        }
        isLoading = false
    }
}

