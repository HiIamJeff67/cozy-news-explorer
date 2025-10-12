import Foundation

struct SongModel: Identifiable, Hashable {
    let id: String
    let title: String
    let artist: String
    let lyrics: String?
    let spotifyId: String
    let imageURL: String?

    func embedURL(isDark: Bool) -> URL {
        let themeParam = isDark ? "0" : "1"
        let urlString = "https://open.spotify.com/embed/track/\(spotifyId)?utm_source=generator&theme=\(themeParam)"
        return URL(string: urlString)!
    }

    var openInSpotifyURL: URL {
        URL(string: "https://open.spotify.com/track/\(spotifyId)")!
    }

    init(
        title: String,
        artist: String,
        spotifyId: String,
        imageURL: String? = nil,
        lyrics: String? = nil
    ) {
        self.id = spotifyId
        self.title = title
        self.artist = artist
        self.spotifyId = spotifyId
        self.imageURL = imageURL
        self.lyrics = lyrics
    }
}
