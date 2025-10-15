import SwiftUI

struct SimplePager<Child: View>: View {
    let pageCount: Int
    @Binding var currentPage: Int
    let dotColor: Color
    let dotInactiveColor: Color
    let dotSize: CGFloat
    let spacing: CGFloat
    let pages: () -> [Child]

    init(
        pageCount: Int,
        currentPage: Binding<Int>,
        dotColor: Color = Color(.label),
        dotInactiveColor: Color = Color(.label).opacity(0.25),
        dotSize: CGFloat = 8,
        spacing: CGFloat = 8,
        children: @escaping () -> [Child]
    ) {
        self.pageCount = pageCount
        self._currentPage = currentPage
        self.dotColor = dotColor
        self.dotInactiveColor = dotInactiveColor
        self.dotSize = dotSize
        self.spacing = spacing
        self.pages = children // place all the children to the pages in order
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentPage) {
                let all = pages()
                ForEach(Array(all.enumerated()), id: \.offset) { index, page in
                    page
                        .tag(index)
                        .contentShape(Rectangle())
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            DotsIndicator(
                pageCount: pageCount,
                currentIndex: currentPage,
                activeColor: dotColor,
                inactiveColor: dotInactiveColor,
                dotSize: dotSize,
                spacing: spacing
            )
            .padding(.vertical, 12)
        }
    }
}
