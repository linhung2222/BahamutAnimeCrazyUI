import SwiftUI

struct BottomTabBarView: View {
    let selectedIndex: Int

    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color(red: 0.90, green: 0.90, blue: 0.90))

            HStack(spacing: 0) {
                // 1. 首頁 (TV Character Icon)
                TabItemView(
                    title: "首頁",
                    isSelected: selectedIndex == 0,
                    activeColor: Color(red: 0.0, green: 0.67, blue: 0.80)
                ) {
                    HomeTVIconView(color: Color(red: 0.0, green: 0.67, blue: 0.80))
                        .frame(width: 26, height: 24)
                }

                // 2. 所有動畫 (Triple Layered Squares Icon)
                TabItemView(
                    title: "所有動畫",
                    isSelected: selectedIndex == 1,
                    activeColor: Color(red: 0.0, green: 0.67, blue: 0.80)
                ) {
                    AllAnimeIconView(color: Color(red: 0.18, green: 0.18, blue: 0.18))
                        .frame(width: 24, height: 24)
                }

                // 3. 收藏 (Heart Outline Icon)
                TabItemView(
                    title: "收藏",
                    isSelected: selectedIndex == 2,
                    activeColor: Color(red: 0.0, green: 0.67, blue: 0.80)
                ) {
                    Image(systemName: "heart")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(Color(red: 0.18, green: 0.18, blue: 0.18))
                }

                // 4. 紀錄 (Clock Outline Icon)
                TabItemView(
                    title: "紀錄",
                    isSelected: selectedIndex == 3,
                    activeColor: Color(red: 0.0, green: 0.67, blue: 0.80)
                ) {
                    Image(systemName: "clock")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(Color(red: 0.18, green: 0.18, blue: 0.18))
                }

                // 5. 我的 (Person Outline Icon)
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

struct TabItemView<IconContent: View>: View {
    let title: String
    let isSelected: Bool
    let activeColor: Color
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

/// Custom Bahamut Anime "首頁" cute smiling TV mascot icon
struct HomeTVIconView: View {
    let color: Color

    var body: some View {
        Canvas { context, size in
            let w = size.width
            let h = size.height
            let strokeStyle = StrokeStyle(lineWidth: 2.0, lineCap: .round, lineJoin: .round)

            // Antenna V on top
            var antenna = Path()
            antenna.move(to: CGPoint(x: w * 0.28, y: 1.5))
            antenna.addLine(to: CGPoint(x: w * 0.46, y: h * 0.23))
            antenna.move(to: CGPoint(x: w * 0.72, y: 1.5))
            antenna.addLine(to: CGPoint(x: w * 0.54, y: h * 0.23))
            context.stroke(antenna, with: .color(color), style: strokeStyle)

            // Outer TV rounded box (slightly trapezoidal or rounded rect)
            let tvRect = CGRect(x: 2, y: h * 0.23, width: w - 4, height: h * 0.72)
            let tvPath = Path(roundedRect: tvRect, cornerRadius: 4)
            context.stroke(tvPath, with: .color(color), style: strokeStyle)

            // Top inner bar / forehead line with center notch
            var topBar = Path()
            topBar.move(to: CGPoint(x: 2.5, y: h * 0.42))
            topBar.addLine(to: CGPoint(x: w - 2.5, y: h * 0.42))
            context.stroke(topBar, with: .color(color), style: StrokeStyle(lineWidth: 1.8, lineCap: .round))

            // Eyes
            var eyes = Path()
            eyes.move(to: CGPoint(x: w * 0.34, y: h * 0.56))
            eyes.addLine(to: CGPoint(x: w * 0.34, y: h * 0.65))
            eyes.move(to: CGPoint(x: w * 0.66, y: h * 0.56))
            eyes.addLine(to: CGPoint(x: w * 0.66, y: h * 0.65))
            context.stroke(eyes, with: .color(color), style: StrokeStyle(lineWidth: 2.0, lineCap: .round))

            // Smile arc
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

/// Custom triple-stacked squares icon for "所有動畫"
struct AllAnimeIconView: View {
    let color: Color

    var body: some View {
        Canvas { context, size in
            let stroke = StrokeStyle(lineWidth: 1.8, lineCap: .round, lineJoin: .round)

            // Front-most top-left rounded square
            let rect1 = CGRect(x: 2, y: 2, width: 14, height: 14)
            context.stroke(Path(roundedRect: rect1, cornerRadius: 2.5), with: .color(color), style: stroke)

            // Middle layer L-shape offset by (3.5, 3.5)
            var layer2 = Path()
            layer2.move(to: CGPoint(x: 19.5, y: 6.5))
            layer2.addLine(to: CGPoint(x: 19.5, y: 17))
            layer2.addQuadCurve(to: CGPoint(x: 17, y: 19.5), control: CGPoint(x: 19.5, y: 19.5))
            layer2.addLine(to: CGPoint(x: 6.5, y: 19.5))
            context.stroke(layer2, with: .color(color), style: stroke)

            // Back layer L-shape offset by (7, 7)
            var layer3 = Path()
            layer3.move(to: CGPoint(x: 23, y: 10))
            layer3.addLine(to: CGPoint(x: 23, y: 20.5))
            layer3.addQuadCurve(to: CGPoint(x: 20.5, y: 23), control: CGPoint(x: 23, y: 23))
            layer3.addLine(to: CGPoint(x: 10, y: 23))
            context.stroke(layer3, with: .color(color), style: stroke)
        }
    }
}
