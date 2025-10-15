import SwiftUI

struct DotsIndicator: View {
    let pageCount: Int
    let currentIndex: Int
    let activeColor: Color
    let inactiveColor: Color
    let dotSize: CGFloat
    let spacing: CGFloat

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<pageCount, id: \.self) { i in
                Circle()
                    .fill(i == currentIndex ? activeColor : inactiveColor)
                    .frame(width: dotSize, height: dotSize)
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Page \(currentIndex + 1) of \(pageCount)")
    }
}
