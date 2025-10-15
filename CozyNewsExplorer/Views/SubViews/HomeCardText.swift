import SwiftUI

struct HomeCardText : View {
    let title: String
    let subtitle: String
    let width: CGFloat
    let height: CGFloat
    let alignment: Alignment
    let reverseStyle: Bool
    
    init(
        title: String,
        subtitle: String,
        width: CGFloat = .infinity,
        height: CGFloat = .infinity,
        alignment: Alignment = .bottomLeading,
        reverseStyle: Bool = false
    ) {
        self.title = title
        self.subtitle = subtitle
        self.width = width
        self.height = height
        self.alignment = alignment
        self.reverseStyle = reverseStyle
    }
    
    var body : some View {
        if reverseStyle {
            VStack(alignment: .leading, spacing: 8) {
                Text(subtitle)
                    .font(.title3)
                    .foregroundStyle(.white)
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .padding(36)
            .frame(width: width, height: height, alignment: alignment)
        } else {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)
                Text(subtitle)
                    .foregroundStyle(.white)
            }
            .padding(36)
            .frame(width: width, height: height, alignment: alignment)
        }
    }
}
