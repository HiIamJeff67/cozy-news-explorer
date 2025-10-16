Cozy News Explorer

以 SwiftUI 打造的輕量 App，結合「新聞閱讀」與「音樂播放」。在閱讀新聞時，也能播放舒適的 Spotify 音樂，並支援主題深淺色切換與迷你播放器。

主要功能
• 分頁導覽
   • 主頁 Home：卡片式導覽與簡單分頁展示（SimplePager）。
   • 音樂 Music：歌曲卡片清單，點擊即可播放，若有歌詞可進入歌詞頁。
   • 新聞 News：頭條新聞 + 所有新聞列表，支援關鍵字搜尋。
• 播放體驗
   • 迷你播放器：內嵌 Spotify Embed（WKWebView），顯示於畫面底部，播放中自動出現。
   • 播放控制：透過 PlayerStore 管理播放清單、目前曲目與播放/暫停/切歌。
• 主題與外觀
   • 主題切換：支援系統/淺色/深色，並套用至整體介面與 Spotify Embed 外觀。
• 新聞來源
   • 使用 NewsAPI（/v2/top-headlines 與 /v2/everything）取得最新新聞。

快速開始
• 需求：Xcode 15+、iOS 17+（可依實際 Deployment Target 調整）
• NewsAPI 設定：
   • 到 https://newsapi.org 申請 API Key
   • 在 Info.plist 加入字串鍵 NewsAPIKey，值為你的 API Key

技術重點（簡述）
• SwiftUI：TabView、NavigationStack、LazyVGrid、AsyncImage
• 狀態管理：EnvironmentObject（ThemeManager、PlayerStore）
• 內嵌內容：WKWebView 載入 Spotify Embed
• 網路層：NewsAPIClient 封裝 NewsAPI 請求與解碼

專案結構（節選）
• UI：ContentView、HomeView、MusicView、NewsView、MiniPlayerView、SongCardView
• 狀態/資料：ThemeManager、PlayerStore、SongModel、Songs
• 新聞：NewsAPIClient、NewsViewModel、Article/Source/NewsAPIResponse、HeadlineCardView、ArticleRowView

備註
• 截圖與示意圖可放在專案的 Assets 資料夾，並於此 README 補上連結。
• Spotify 內容使用官方 Embed，實際播放體驗受 Spotify 服務限制。
