import SwiftUI
import Combine

@MainActor
final class PlayerStore: ObservableObject {
    @Published private(set) var playlist: [SongModel] = []
    @Published private(set) var current: SongModel?
    @Published private(set) var isPlaying: Bool = false
    
    var currentIndex: Int? {
        guard let current else { return nil }
        return playlist.firstIndex(of: current)
    }
    
    init(songs: [SongModel] = []) {
        load(songs)
    }
    
    func load(_ songs: [SongModel], startAt index: Int? = nil, autoPlay: Bool = false) {
        playlist = songs
        if let idx = index, playlist.indices.contains(idx) {
            // the above if statement include two operations
            //   1. get the index as idx
            //   2. execute the playlis.indices.contains(idx)
            //      - which means checking if the given index is exist in the playlist
            current = playlist[idx]
            isPlaying = autoPlay
        } else {
            current = nil
            isPlaying = false
        }
    }
    
    func enqueue(_ songs: [SongModel], allowDuplicates: Bool = false) {
        if allowDuplicates {
            playlist.append(contentsOf: songs)
        } else {
            let toAppend = songs.filter { !playlist.contains($0) }
            // the above code is equivalent to the below code:
            // let toAppend = songs.filter { song in return !playlist.contains(song) }
            // $0 means the first parameter of songs which is the song for each songs
            playlist.append(contentsOf: toAppend)
        }
    }
    
    func insert(_ song: SongModel, at index: Int) {
        let idx = max(0, min(index, playlist.count))
        if !playlist.contains(song) {
            playlist.insert(song, at: idx)
        } else {
            if let old = playlist.firstIndex(of: song) {
                playlist.remove(at: old)
            }
            let newIdx = max(0, min(index, playlist.count))
            playlist.insert(song, at: newIdx)
        }
    }
    
    func remove(at offsets: IndexSet) {
        // if the index of the current song is included in the indexes of the deleted songs, then we have to handle some
        if let curIdx = currentIndex, offsets.contains(curIdx) {
            playlist.remove(atOffsets: offsets)
            if playlist.indices.contains(curIdx) {
                current = playlist[curIdx]
                isPlaying = true
            } else if let lastIdx = playlist.indices.last {
                current = playlist[lastIdx]
                isPlaying = true
            } else {
                stop()
            }
        } else {
            playlist.remove(atOffsets: offsets)
            // if the current song is somehow doesn't exist in the playlist which should not happened,
            // then we will stop the player just in case
            if let current, !playlist.contains(current) {
                stop()
            }
        }
    }
    
    func clearPlaylist() {
        playlist.removeAll()
        stop()
    }
    
    // MARK: - Player Controll
    func play(_ track: SongModel) {
        if let idx = playlist.firstIndex(of: track) {
            play(at: idx)
        } else {
            playlist.append(track)
            play(at: playlist.count - 1)
        }
    }
    
    func play(at index: Int) {
        guard playlist.indices.contains(index) else { return }
        current = playlist[index]
        isPlaying = true
    }
    
    func pause() {
        isPlaying = false
    }
    
    func resume() {
        guard current != nil else { return }
        isPlaying = true
    }
    
    func togglePlayPause() {
        isPlaying ? pause() : resume()
    }
    
    func next() {
        guard let idx = currentIndex else {
            if !playlist.isEmpty { play(at: 0) }
            return
        }
        let nextIdx = idx + 1
        if playlist.indices.contains(nextIdx) {
            play(at: nextIdx)
        } else {
            stop()
        }
    }
    
    func previous() {
        guard let idx = currentIndex else { return }
        let prevIdx = idx - 1
        if playlist.indices.contains(prevIdx) {
            play(at: prevIdx)
        } else {
            play(at: 0)
        }
    }
    
    func stop() {
        current = nil
        isPlaying = false
    }
}
