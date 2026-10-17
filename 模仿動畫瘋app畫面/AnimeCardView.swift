import SwiftUI

/// 單一動畫卡片視圖元件
/// 負責呈現 16:9 動畫封面縮圖、右上角愛心收藏互動按鈕、左下角「付費會員」標籤、右下角觀看次數，以及下方的番劇標題、更新時間與集數
struct AnimeCardView: View {
    /// 單筆動畫作品的資料模型
    let anime: AnimeItem
    /// 卡片寬度（由外部 `GeometryReader` 計算後傳入）
    let cardWidth: CGFloat
    /// 卡片縮圖高度（依照 16:9 比例計算後傳入）
    let cardHeight: CGFloat
    /// 紀錄使用者是否已點擊收藏此部動畫（控制右上角愛心圖示顏色切換）
    @State private var isFavorited = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // 16:9 動畫縮圖容器：使用 ZStack 疊加圖片、底部暗角漸層、右上角愛心與底部資訊列
            ZStack {
                // 底層：動畫封面圖片（填滿並裁切多餘邊界）
                Image(anime.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardWidth, height: cardHeight)
                    .clipped()

                // 中層：底部黑色半透明線性漸層遮罩，確保白色觀看次數文字與標籤清晰易讀
                VStack {
                    Spacer()
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.65)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 38)
                }

                // 上層右上角：互動式愛心收藏按鈕（點擊可切換粉紅實心愛心與半透明黑底白框愛心）
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            isFavorited.toggle()
                        } label: {
                            ZStack {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 22))
                                    .foregroundStyle(isFavorited ? Color.pink : Color.black.opacity(0.38))
                                Image(systemName: "heart")
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundStyle(.white)
                            }
                            .shadow(color: .black.opacity(0.35), radius: 2, x: 0, y: 1)
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                    }
                    Spacer()
                }

                // 上層底部列：左側可選的金色「付費會員」標籤，右側為眼睛圖示與觀看次數
                VStack {
                    Spacer()
                    HStack(alignment: .center) {
                        // 若為 VIP 專屬番劇，於左下角顯示「付費會員」金棕色標籤
                        if anime.isVIPOnly {
                            Text("付費會員")
                                .font(.system(size: 11.5, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2.5)
                                .background(
                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                        .fill(Color(red: 0.72, green: 0.50, blue: 0.20))
                                )
                        }

                        Spacer()

                        // 右下角：眼睛圖示 + 累計觀看人數
                        HStack(spacing: 4) {
                            EyeIconView()
                                .frame(width: 15, height: 11)
                            Text(anime.views)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 6)
                }
            }
            .frame(width: cardWidth, height: cardHeight)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            // 動畫名稱標題（限制單行顯示，過長時於尾端顯示省略號 `...`）
            Text(anime.title)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color(red: 0.12, green: 0.12, blue: 0.12))
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(.top, 2)

            // 底部資訊列：左側顯示更新日期與時間，右側顯示最新集數
            HStack {
                Text(anime.dateTime)
                    .font(.system(size: 13.5, weight: .regular))
                    .foregroundStyle(Color(red: 0.58, green: 0.58, blue: 0.58))

                Spacer()

                Text(anime.episode)
                    .font(.system(size: 13.5, weight: .regular))
                    .foregroundStyle(Color(red: 0.58, green: 0.58, blue: 0.58))
            }
        }
        .frame(width: cardWidth)
    }
}

/// 觀看次數旁的白色實心眼睛圖示元件
struct EyeIconView: View {
    var body: some View {
        ZStack {
            Image(systemName: "eye.fill")
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(.white)
        }
    }
}
