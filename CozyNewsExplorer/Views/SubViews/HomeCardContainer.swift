import SwiftUI

struct HomeCardContainer<Content: View>: View {
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let contentAlignment: Alignment
    let backgroundStyle: AnyShapeStyle
    @ViewBuilder var content: () -> Content

    init(
        width: CGFloat,
        height: CGFloat,
        cornerRadius: CGFloat = 24,
        contentAlignment: Alignment = .center,
        backgroundStyle: some ShapeStyle = .regularMaterial,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.contentAlignment = contentAlignment
        self.backgroundStyle = AnyShapeStyle(backgroundStyle)
        self.content = content
    }

    var body: some View {
        ZStack {
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: contentAlignment)
        }
        .frame(width: width, height: height, alignment: contentAlignment)
        .background(
            backgroundStyle,
            in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        )
        .shadow(color: .black.opacity(0.18), radius: 16, x: 0, y: 12)
    }
}
