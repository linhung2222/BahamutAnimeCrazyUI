import SwiftUI

/// 底部固定式五個分頁導覽列視圖（Tab Bar）
/// 包含「首頁」、「所有動畫」、「收藏」、「紀錄」與「我的」五個導覽項目
struct BottomTabBarView: View {
    /// 目前選中的分頁索引（`0` 為首頁）
    let selectedIndex: Int

    var body: some View {
        VStack(spacing: 0) {
            // 頂部細分隔線，區隔內容捲動區與底部導覽列
            Divider()
                .background(Color(red: 0.90, green: 0.90, blue: 0.90))

            HStack(spacing: 0) {
                // 1. 首頁（手繪巴哈姆特微笑小電視吉祥物圖示，預設為青藍色選中狀態）
                TabItemView(
                    title: "首頁",
                    isSelected: selectedIndex == 0,
                    activeColor: Color(red: 0.0, green: 0.67, blue: 0.80)
                ) {
                    HomeTVIconView(color: Color(red: 0.0, green: 0.67, blue: 0.80))
                        .frame(width: 26, height: 24)
                }

                // 2. 所有動畫（手繪三層疊加方塊圖示）
                TabItemView(
                    title: "所有動畫",
                    isSelected: selectedIndex == 1,
                    activeColor: Color(red: 0.0, green: 0.67, blue: 0.80)
                ) {
                    AllAnimeIconView(color: Color(red: 0.18, green: 0.18, blue: 0.18))
                        .frame(width: 24, height: 24)
                }

                // 3. 收藏（空心愛心圖示）
                TabItemView(
                    title: "收藏",
                    isSelected: selectedIndex == 2,
                    activeColor: Color(red: 0.0, green: 0.67, blue: 0.80)
                ) {
                    Image(systemName: "heart")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(Color(red: 0.18, green: 0.18, blue: 0.18))
                }

                // 4. 紀錄（空心時鐘圖示）
                TabItemView(
                    title: "紀錄",
                    isSelected: selectedIndex == 3,
                    activeColor: Color(red: 0.0, green: 0.67, blue: 0.80)
                ) {
                    Image(systemName: "clock")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(Color(red: 0.18, green: 0.18, blue: 0.18))
                }

                // 5. 我的（個人輪廓圖示）
                TabItemView(
                    title: "我的",
                    isSelected: selectedIndex == 4,
                    activeColor: Color(red: 0.0, green: 0.67, blue: 0.80)
                ) {
                    Image(systemName: "person")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(Color(red: 0.18, green: 0.18, blue: 0.18))
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 4)
            .background(Color.white)
        }
        .background(Color.white)
    }
}

/// 單一底部分頁項目視圖容器
/// 使用泛型與 `@ViewBuilder` 接收自訂圖示視圖，並於下方配置分頁標題文字
struct TabItemView<IconContent: View>: View {
    /// 分頁標題文字
    let title: String
    /// 是否為目前選中的分頁
    let isSelected: Bool
    /// 選中時的強調色（動畫瘋青藍色）
    let activeColor: Color
    /// 分頁圖示內容建構閉包
    @ViewBuilder let icon: () -> IconContent

    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                icon()
            }
            .frame(height: 25)

            Text(title)
                .font(.system(size: 11.5, weight: isSelected ? .medium : .regular))
                .foregroundStyle(isSelected ? activeColor : Color(red: 0.22, green: 0.22, blue: 0.22))
        }
        .frame(maxWidth: .infinity)
    }
}

/// 自訂手繪的巴哈姆特動畫瘋「首頁」微笑小電視吉祥物圖示
/// 使用 `Canvas` 繪製頂部 V 型天線、圓角電視外框、上方橫條與微笑五官
struct HomeTVIconView: View {
    /// 圖示線條顏色
    let color: Color

    var body: some View {
        Canvas { context, size in
            let w = size.width
            let h = size.height
            let strokeStyle = StrokeStyle(lineWidth: 2.0, lineCap: .round, lineJoin: .round)

            // 1. 電視頂部的 V 型雙天線
            var antenna = Path()
            antenna.move(to: CGPoint(x: w * 0.28, y: 1.5))
            antenna.addLine(to: CGPoint(x: w * 0.46, y: h * 0.23))
            antenna.move(to: CGPoint(x: w * 0.72, y: 1.5))
            antenna.addLine(to: CGPoint(x: w * 0.54, y: h * 0.23))
            context.stroke(antenna, with: .color(color), style: strokeStyle)

            // 2. 電視機圓角矩形外框
            let tvRect = CGRect(x: 2, y: h * 0.23, width: w - 4, height: h * 0.72)
            let tvPath = Path(roundedRect: tvRect, cornerRadius: 4)
            context.stroke(tvPath, with: .color(color), style: strokeStyle)

            // 3. 電視螢幕上方的裝飾橫線（瀏海線條）
            var topBar = Path()
            topBar.move(to: CGPoint(x: 2.5, y: h * 0.42))
            topBar.addLine(to: CGPoint(x: w - 2.5, y: h * 0.42))
            context.stroke(topBar, with: .color(color), style: StrokeStyle(lineWidth: 1.8, lineCap: .round))

            // 4. 左右兩側的垂直短線眼睛
            var eyes = Path()
            eyes.move(to: CGPoint(x: w * 0.34, y: h * 0.56))
            eyes.addLine(to: CGPoint(x: w * 0.34, y: h * 0.65))
            eyes.move(to: CGPoint(x: w * 0.66, y: h * 0.56))
            eyes.addLine(to: CGPoint(x: w * 0.66, y: h * 0.65))
            context.stroke(eyes, with: .color(color), style: StrokeStyle(lineWidth: 2.0, lineCap: .round))

            // 5. 二次貝茲曲線繪製的微笑嘴巴弧線
            var smile = Path()
            smile.move(to: CGPoint(x: w * 0.40, y: h * 0.74))
            smile.addQuadCurve(
                to: CGPoint(x: w * 0.60, y: h * 0.74),
                control: CGPoint(x: w * 0.50, y: h * 0.85)
            )
            context.stroke(smile, with: .color(color), style: StrokeStyle(lineWidth: 1.8, lineCap: .round))
        }
    }
}

/// 自訂手繪的「所有動畫」三層疊加方塊圖示
/// 使用 `Canvas` 繪製左上角主方塊與右下角兩層 L 型疊加陰影邊框
struct AllAnimeIconView: View {
    /// 圖示線條顏色
    let color: Color

    var body: some View {
        Canvas { context, size in
            let stroke = StrokeStyle(lineWidth: 1.8, lineCap: .round, lineJoin: .round)

            // 第一層（最前方）：左上角完整圓角正方形
            let rect1 = CGRect(x: 2, y: 2, width: 14, height: 14)
            context.stroke(Path(roundedRect: rect1, cornerRadius: 2.5), with: .color(color), style: stroke)

            // 第二層（中間層）：向右下偏移 (3.5, 3.5) 的 L 型圓角邊框
            var layer2 = Path()
            layer2.move(to: CGPoint(x: 19.5, y: 6.5))
            layer2.addLine(to: CGPoint(x: 19.5, y: 17))
            layer2.addQuadCurve(to: CGPoint(x: 17, y: 19.5), control: CGPoint(x: 19.5, y: 19.5))
            layer2.addLine(to: CGPoint(x: 6.5, y: 19.5))
            context.stroke(layer2, with: .color(color), style: stroke)

            // 第三層（最底層）：向右下偏移 (7, 7) 的 L 型圓角邊框
            var layer3 = Path()
            layer3.move(to: CGPoint(x: 23, y: 10))
            layer3.addLine(to: CGPoint(x: 23, y: 20.5))
            layer3.addQuadCurve(to: CGPoint(x: 20.5, y: 23), control: CGPoint(x: 23, y: 23))
            layer3.addLine(to: CGPoint(x: 10, y: 23))
            context.stroke(layer3, with: .color(color), style: stroke)
        }
    }
}
