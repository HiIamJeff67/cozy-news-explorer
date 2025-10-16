import Foundation

enum NewsAPIError: Error, LocalizedError {
    case missingAPIKey
    case invalidURL
    case httpStatus(Int, String?)
    case apiMessage(String)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .missingAPIKey: return "Missing NewsAPI key"
        case .invalidURL: return "Invalid URL"
        case .httpStatus(let code, let body): return "HTTP status \(code)\(body.flatMap { ": \($0)" } ?? "")"
        case .apiMessage(let msg): return msg
        case .decoding(let err): return "Decoding error: \(err.localizedDescription)"
        }
    }
}

struct NewsAPIClient {
    private let session: URLSession
    private let apiKey: String
    private let baseURL = URL(string: "https://newsapi.org/v2")!

    init(session: URLSession = .shared) throws {
        guard var key = Bundle.main.object(forInfoDictionaryKey: "NewsAPIKey") as? String,
              key.isEmpty == false else {
            throw NewsAPIError.missingAPIKey
        }
        key = key.trimmingCharacters(in: .whitespacesAndNewlines)
        if key.hasPrefix("\"") && key.hasSuffix("\"") && key.count >= 2 {
            key = String(key.dropFirst().dropLast())
        }
        self.session = session
        self.apiKey = key
    }

    // MARK: - Endpoints

    // /v2/top-headlines
    func searchTopHeadlines(
        country: String? = "us",
        category: String? = nil,
        q: String? = nil,
        sources: String? = nil,
        pageSize: Int = 20
    ) async throws -> [Article] {
        var comps = URLComponents(url: baseURL.appendingPathComponent("top-headlines"), resolvingAgainstBaseURL: false)
        var items: [URLQueryItem] = [.init(name: "pageSize", value: String(pageSize))]
        if let country { items.append(.init(name: "country", value: country)) }
        if let category { items.append(.init(name: "category", value: category)) }
        if let q { items.append(.init(name: "q", value: q)) }
        if let sources { items.append(.init(name: "sources", value: sources)) }
        comps?.queryItems = items
        guard let url = comps?.url else { throw NewsAPIError.invalidURL }
        return try await request(url: url)
    }

    // /v2/everything
    func searchEverything(
        q: String,
        from: String? = nil,          // 例如 "2025-10-12"
        to: String? = nil,            // 例如 "2025-10-12"
        sortBy: String? = "publishedAt", // relevance / popularity / publishedAt
        language: String? = "en",
        pageSize: Int = 20
    ) async throws -> [Article] {
        var comps = URLComponents(url: baseURL.appendingPathComponent("everything"), resolvingAgainstBaseURL: false)
        var items: [URLQueryItem] = [
            .init(name: "q", value: q),
            .init(name: "pageSize", value: String(pageSize))
        ]
        if let from { items.append(.init(name: "from", value: from)) }
        if let to { items.append(.init(name: "to", value: to)) }
        if let sortBy { items.append(.init(name: "sortBy", value: sortBy)) }
        if let language { items.append(.init(name: "language", value: language)) }
        comps?.queryItems = items
        guard let url = comps?.url else { throw NewsAPIError.invalidURL }
        return try await request(url: url)
    }


    private func request(url: URL) async throws -> [Article] {
        var req = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        req.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")

        let (data, resp) = try await session.data(for: req)
        guard let http = resp as? HTTPURLResponse else { throw NewsAPIError.httpStatus(-1, nil) }
        guard (200..<300).contains(http.statusCode) else {
            let bodyText = String(data: data, encoding: .utf8)
            if let apiError = try? JSONDecoder().decode(NewsAPIResponse.self, from: data),
               let msg = apiError.message, !msg.isEmpty {
                throw NewsAPIError.apiMessage(msg)
            }
            throw NewsAPIError.httpStatus(http.statusCode, bodyText)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let result = try decoder.decode(NewsAPIResponse.self, from: data)
            if result.status != "ok" {
                throw NewsAPIError.apiMessage(result.message ?? "API not ok")
            }
            return result.articles
        } catch {
            throw NewsAPIError.decoding(error)
        }
    }
}
