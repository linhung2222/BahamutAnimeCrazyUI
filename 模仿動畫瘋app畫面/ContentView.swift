import SwiftUI

struct ContentView: View {
    @State private var selectedTabIndex: Int = 0
    let animeList: [AnimeItem] = AnimeItem.sampleData

    // Pair anime items into rows of 2 so we explicitly use HStack and VStack inside ScrollView
    private var animeRows: [[AnimeItem]] {
        stride(from: 0, to: animeList.count, by: 2).map { index in
            Array(animeList[index..<min(index + 2, animeList.count)])
        }
    }

    var body: some View {
        GeometryReader { geometry in
            let horizontalPadding: CGFloat = 16
            let columnSpacing: CGFloat = 12
            // Responsive card sizing tailored for iPhone 18 Pro Max (width ~440pt) and all iPhone sizes
            let availableWidth = max(geometry.size.width - (horizontalPadding * 2) - columnSpacing, 200)
            let cardWidth = availableWidth / 2
            let cardHeight = cardWidth * 0.5625 // 16:9 widescreen thumbnail ratio

            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 0) {
                    // Fixed Top Header (Logo, Cast/Search, 本季新番 / 週期表, Sort icon)
                    TopBarView(
                        logoImageName: "bahamut_logo",
                        activeCategory: "本季新番",
                        secondaryCategory: "週期表"
                    )

                    // Vertical ScrollView for scrolling up and down through all 15 rows (30 anime cards)
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(spacing: 18) {
                            ForEach(Array(animeRows.enumerated()), id: \.offset) { _, rowItems in
                                HStack(alignment: .top, spacing: columnSpacing) {
                                    ForEach(rowItems) { anime in
                                        AnimeCardView(
                                            anime: anime,
                                            cardWidth: cardWidth,
                                            cardHeight: cardHeight
                                        )
                                    }
                                    if rowItems.count == 1 {
                                        Spacer(minLength: cardWidth)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, 8)
                        .padding(.bottom, 24)
                    }

                    // Fixed Bottom Tab Bar
                    BottomTabBarView(selectedIndex: selectedTabIndex)
                }
                .background(Color.white)

                // Floating Action Buttons (新番情報 & VIP) anchored above Bottom Tab Bar on the bottom right
                FloatingButtonsView(
                    infoLabel: "新番情報",
                    vipLabel: "VIP",
                    circleDiameter: 62
                )
                .padding(.trailing, 14)
                .padding(.bottom, 68)
            }
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    ContentView()
}
