import SwiftUI

struct LyricsModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .fixedSize(horizontal: false, vertical: true)
    }
}
