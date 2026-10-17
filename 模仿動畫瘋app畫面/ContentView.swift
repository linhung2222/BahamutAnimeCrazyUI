import SwiftUI

/// 巴哈姆特動畫瘋首頁的主畫面視圖
/// 整合固定式頂部導覽列、可上下捲動的雙欄動畫卡片列表、底部五個分頁導覽列，以及右下角懸浮按鈕
struct ContentView: View {
    /// 目前選中的底部分頁索引（預設 `0` 為「首頁」）
    @State private var selectedTabIndex: Int = 0
    /// 動畫作品清單資料（載入內建的 30 筆迷因主題新番假資料）
    let animeList: [AnimeItem] = AnimeItem.sampleData

    /// 將一維的動畫陣列每 2 筆分組為一列（Row），方便在 `ScrollView` 中使用 `VStack` 搭配 `HStack` 排出雙欄網格
    private var animeRows: [[AnimeItem]] {
        stride(from: 0, to: animeList.count, by: 2).map { index in
            Array(animeList[index..<min(index + 2, animeList.count)])
        }
    }

    var body: some View {
        // 使用 GeometryReader 動態取得螢幕寬度，以自動計算雙欄卡片的 16:9 尺寸並適配各種 iPhone 機型
        GeometryReader { geometry in
            // 左右邊距（16pt）與雙欄之間的水平間距（12pt）
            let horizontalPadding: CGFloat = 16
            let columnSpacing: CGFloat = 12
            // 扣除左右內距與欄位間距後，計算可用的總寬度（設定最小保護值 200pt 避免異常負數）
            let availableWidth = max(geometry.size.width - (horizontalPadding * 2) - columnSpacing, 200)
            // 單張動畫卡片的寬度（雙欄平分可用寬度）
            let cardWidth = availableWidth / 2
            // 單張動畫卡片縮圖的高度（依照 16:9 寬螢幕黃金比例計算：9 / 16 = 0.5625）
            let cardHeight = cardWidth * 0.5625

            // 最外層使用 ZStack（對齊右下角），讓「新番情報」與「VIP」懸浮按鈕固定疊加在畫面右下方
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 0) {
                    // 1. 固定式頂部導覽列（包含動畫瘋 Logo、電視投影與搜尋圖示、「本季新番／週期表」切換標籤與排序篩選圖示）
                    TopBarView(
                        logoImageName: "bahamut_logo",
                        activeCategory: "本季新番",
                        secondaryCategory: "週期表"
                    )

                    // 2. 垂直捲動區域：可上下滑動瀏覽全部 15 列（共 30 張）動畫卡片
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(spacing: 18) {
                            // 逐列建立雙欄結構
                            ForEach(Array(animeRows.enumerated()), id: \.offset) { _, rowItems in
                                HStack(alignment: .top, spacing: columnSpacing) {
                                    // 繪製該列中的每一張動畫卡片（每列最多 2 張）
                                    ForEach(rowItems) { anime in
                                        AnimeCardView(
                                            anime: anime,
                                            cardWidth: cardWidth,
                                            cardHeight: cardHeight
                                        )
                                    }
                                    // 若最後一列只有 1 張卡片，補上等寬的 Spacer 以維持靠左對齊版面
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

                    // 3. 固定式底部五個分頁導覽列（首頁、所有動畫、收藏、紀錄、我的）
                    BottomTabBarView(selectedIndex: selectedTabIndex)
                }
                .background(Color.white)

                // 4. 右下角懸浮操作按鈕（「新番情報」與「VIP」圓形漸層按鈕），固定於底部導覽列上方
                FloatingButtonsView(
                    infoLabel: "新番情報",
                    vipLabel: "VIP",
                    circleDiameter: 62
                )
                .padding(.trailing, 14)
                .padding(.bottom, 68)
            }
            // 強制使用淺色模式（Light Mode），完整還原原版截圖的白底視覺風格
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    ContentView()
}
