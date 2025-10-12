import SwiftUI
import WebKit

struct MiniPlayerView: View {
    @EnvironmentObject private var player: PlayerStore
    @EnvironmentObject private var theme: ThemeManager
    
    var body: some View {
        if let track = player.current {
            MiniSpotifyEmbedView(url: track.embedURL(isDark: theme.isDark))
                .frame(height: 96)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(radius: 3, y: 1)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(track.title), \(track.artist)")
        }
    }
}

// MARK: - Private embedded WebView just for MiniPlayer

private struct MiniSpotifyEmbedView: View {
    let url: URL
    
    var body: some View {
        Representable(url: url)
            .background(Color.clear)
    }
}

private extension MiniSpotifyEmbedView {
    struct Representable: UIViewRepresentable {
        let url: URL
        
        func makeUIView(context: Context) -> WKWebView {
            let config = WKWebViewConfiguration()
            config.allowsInlineMediaPlayback = true
            if #available(iOS 10.0, tvOS 10.0, *) {
                config.mediaTypesRequiringUserActionForPlayback = []
            }
            let webView = WKWebView(frame: .zero, configuration: config)
            webView.backgroundColor = .clear
            webView.isOpaque = false
            webView.scrollView.isScrollEnabled = false
            webView.scrollView.bounces = false
            
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
            webView.load(request)
            return webView
        }
        
        func updateUIView(_ webView: WKWebView, context: Context) {
            guard webView.url != url else { return }
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
            webView.load(request)
        }
    }
}
