import SwiftUI

struct HomeView: View {
    @State private var showContent = false
    @State private var currentPage = 0

    private let colorLight = Color(red: 226/255, green: 224/255, blue: 212/255) // #e2e0d4
    private let colorMid   = Color(red: 220/255, green: 206/255, blue: 169/255) // #dccea9
    private let colorAccent = Color(red: 146/255, green: 72/255, blue: 38/255)  // #924826

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [colorLight, colorMid],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(alignment: .leading) {
                Spacer(minLength: 0)

                if showContent {
                    HomeCardContainer(
                        width: .infinity,
                        height: .infinity,
                        cornerRadius: 24,
                        contentAlignment: .bottomTrailing,
                        backgroundStyle: .regularMaterial
                    ) {
                        SimplePager(
                            pageCount: 3,
                            currentPage: $currentPage,
                            dotColor: colorAccent,
                            dotInactiveColor: colorAccent.opacity(0.3),
                            dotSize: 8,
                            spacing: 8
                        ) {
                            [
                                AnyView(
                                    ZStack {
                                        Image("RainyJapaneseHouse")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .clipped()
                                            .zIndex(0)
                                        HomeCardText(
                                            title: "Cozy News Explorer",
                                            subtitle: "Welcome to",
                                            width: .infinity,
                                            height: .infinity,
                                            reverseStyle: true
                                        )
                                        .zIndex(1000)
                                        .scaledToFit()
                                    }
                                ),
                                AnyView(
                                    ZStack {
                                        Image("SnowFujiMt")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .clipped()
                                            .zIndex(0)
                                        HomeCardText(
                                            title: "Pick a cozy music",
                                            subtitle: "Stay cozy and relax while your're reading",
                                            width: .infinity,
                                            height: .infinity
                                        )
                                        .zIndex(1000)
                                        .scaledToFit()
                                    }
                                ),
                                AnyView(
                                    ZStack {
                                        Image("CozyFujiMt")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .clipped()
                                            .zIndex(0)
                                        HomeCardText(
                                            title: "Explore the news",
                                            subtitle: "Top headline news or your interest topic",
                                            width: .infinity,
                                            height: .infinity
                                        )
                                        .zIndex(1000)
                                        .scaledToFit()
                                    }
                                )
                            ]
                        } // SimplePager view
                    } // HomeCardContainer view
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .transition(.cardTransition)
                    .padding(16)
                } // showContent statement

                Spacer(minLength: 0)
            } // VStack view
            .padding(.horizontal, 20)
        } // ZStack view
        .task {
            try? await Task.sleep(nanoseconds: 180_000_000)
            withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
                showContent = true
            }
        }
    }
}

private extension AnyTransition {
    static var cardTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
            .combined(with: .opacity)
        let removal = AnyTransition.scale(scale: 0.85)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

#Preview {
    HomeView()
}
