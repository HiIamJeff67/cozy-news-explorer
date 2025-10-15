import SwiftUI

struct ConcentricRingsBackground: View {
    var palette: [Color]
    var animate: Bool = true
    var rotationSpeed: Double = 8 // 秒/圈（數字越小轉越快）

    @State private var angle: Angle = .degrees(0)

    var body: some View {
        ZStack {
            RadialGradient(
                colors: [
                    (palette[safe: 0] ?? .white),
                    (palette[safe: 1] ?? .gray).opacity(0.95)
                ],
                center: .center,
                startRadius: 0,
                endRadius: 800
            )
            .ignoresSafeArea()

            // 同心圓
            GeometryReader { proxy in
                let minSide = min(proxy.size.width, proxy.size.height)
                let ringColors = [
                    (palette[safe: 2] ?? .brown).opacity(0.20),
                    (palette[safe: 2] ?? .brown).opacity(0.10),
                    (palette[safe: 0] ?? .white).opacity(0.15)
                ]

                ZStack {
                    ForEach(0..<6, id: \.self) { i in
                        Circle()
                            .strokeBorder(ringColors[i % ringColors.count], lineWidth: 1)
                            .frame(width: minSide * (0.35 + CGFloat(i) * 0.1),
                                   height: minSide * (0.35 + CGFloat(i) * 0.1))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    // 旋轉角向漸層光暈
                    AngularGradient(
                        gradient: Gradient(colors: [
                            (palette[safe: 2] ?? .brown).opacity(0.25),
                            .clear,
                            (palette[safe: 0] ?? .white).opacity(0.25),
                            .clear
                        ]),
                        center: .center,
                        angle: angle
                    )
                    .blendMode(.plusLighter)
                )
            }
            .padding(24)
        }
        .onAppear {
            guard animate else { return }
            withAnimation(.linear(duration: rotationSpeed).repeatForever(autoreverses: false)) {
                angle = .degrees(360)
            }
        }
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        (indices.contains(index)) ? self[index] : nil
    }
}
