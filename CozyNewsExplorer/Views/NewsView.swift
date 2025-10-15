import SwiftUI

struct NewsView : View {
    @EnvironmentObject private var theme: ThemeManager
    
    // the NewsViewModel is a ObservableObject, so it may change the current view and force it to re-render
    @StateObject private var vm = NewsViewModel()
    @State private var query: String = ""

    var body : some View {
        NavigationStack {
            Group {
                if vm.isLoading && vm.topHeadlines.isEmpty && vm.allArticles.isEmpty {
                    ProgressView("Loading news...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = vm.errorMessage, vm.topHeadlines.isEmpty && vm.allArticles.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.yellow)
                        Text(error).multilineTextAlignment(.center)
                        Button("Retry") {
                            Task { await vm.loadInitial() }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            if !vm.topHeadlines.isEmpty {
                                Text("頭條新聞")
                                    .font(.title2).bold()
                                    .padding(.horizontal)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(vm.topHeadlines) { article in
                                            HeadlineCardView(article: article)
                                                .frame(width: 280, height: 160)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }

                            Divider().padding(.horizontal)

                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("所有新聞")
                                        .font(.title3).bold()
                                    Spacer()
                                }
                                .padding(.horizontal)

                                HStack {
                                    TextField("搜尋關鍵字", text: $query)
                                        .textFieldStyle(.roundedBorder)
                                    Button {
                                        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
                                        guard !q.isEmpty else { return }
                                        Task { await vm.search(query: q) }
                                    } label: {
                                        Image(systemName: "magnifyingglass")
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                                .padding(.horizontal)
                            }

                            LazyVStack(spacing: 12) {
                                ForEach(vm.allArticles) { article in
                                    ArticleRowView(article: article)
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.bottom, 24)
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: goToMyGithub) {
                                Image(systemName: "heart.fill")
                                Text("Buy me a coffee !")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: theme.toggle) {
                                Image(systemName: theme.isDark ? "sun.max.fill" : "moon.fill")
                                    .font(.title3)
                                    .foregroundStyle(theme.isDark ? .orange : .blue)
                                    .symbolEffect(.bounce, value: theme.isDark)
                            }
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                        }
                    }
                    .toolbarColorScheme(theme.isDark ? .dark : .light, for: .navigationBar)
                    .toolbarBackground(theme.isDark ? .black.opacity(0.3) : .white.opacity(0.3), for: .navigationBar)
                }
            }
            .navigationTitle("新聞")
        }
        .task {
            await vm.loadInitial()
        }
    }
}
