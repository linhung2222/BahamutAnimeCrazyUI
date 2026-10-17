import SwiftUI

/// 固定於畫面右下角的雙圓形懸浮操作按鈕（Floating Action Buttons）
/// 上方為青藍色漸層的「新番情報」大聲公按鈕（含右上角紅點通知），下方為珊瑚粉漸層的「VIP」星星勳章緞帶按鈕
struct FloatingButtonsView: View {
    /// 上方按鈕文字標籤（例如：`"新番情報"`）
    let infoLabel: String
    /// 下方按鈕文字標籤（例如：`"VIP"`）
    let vipLabel: String
    /// 圓形懸浮按鈕的直徑尺寸
    let circleDiameter: CGFloat

    var body: some View {
        VStack(spacing: 12) {
            // 1. 上方：青藍色漸層「新番情報」圓形按鈕 + 右上角紅色通知圓點
            ZStack(alignment: .topTrailing) {
                ZStack {
                    // 青藍色垂直線性漸層圓形底圖與陰影
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.08, green: 0.72, blue: 0.85),
                                    Color(red: 0.05, green: 0.65, blue: 0.78)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: circleDiameter, height: circleDiameter)
                        .shadow(color: .black.opacity(0.18), radius: 5, x: 0, y: 2)

                    // 大聲公圖示與「新番情報」文字
                    VStack(spacing: 2) {
                        MegaphoneIconView()
                            .frame(width: 30, height: 22)
                        Text(infoLabel)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .offset(y: 1)
                }

                // 右上角紅色未讀通知小圓點
                Circle()
                    .fill(Color(red: 0.96, green: 0.26, blue: 0.21))
                    .frame(width: 11, height: 11)
                    .offset(x: -2, y: 2)
            }

            // 2. 下方：珊瑚粉紅漸層「VIP」勳章圓形按鈕
            ZStack {
                // 珊瑚粉紅垂直線性漸層圓形底圖與陰影
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.94, green: 0.42, blue: 0.44),
                                Color(red: 0.90, green: 0.35, blue: 0.38)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: circleDiameter, height: circleDiameter)
                    .shadow(color: .black.opacity(0.18), radius: 5, x: 0, y: 2)

                // 白色星星勳章與雙燕尾緞帶圖示
                VIPRibbonIconView(label: vipLabel)
                    .frame(width: 38, height: 46)
                    .offset(y: 2)
            }
        }
    }
}

/// 自訂繪製的「新番情報」大聲公圖示（左側帶有三條發聲波紋線條）
struct MegaphoneIconView: View {
    var body: some View {
        HStack(spacing: 3) {
            // 左側三條呈放射角度排列的發聲波紋膠囊線條
            VStack(alignment: .trailing, spacing: 4) {
                Capsule()
                    .fill(.white)
                    .frame(width: 5, height: 2)
                    .rotationEffect(.degrees(28))
                Capsule()
                    .fill(.white)
                    .frame(width: 6, height: 2)
                Capsule()
                    .fill(.white)
                    .frame(width: 5, height: 2)
                    .rotationEffect(.degrees(-28))
            }

            // 水平翻轉朝左並微調仰角的大聲公本體圖示
            Image(systemName: "megaphone.fill")
                .font(.system(size: 19, weight: .bold))
                .foregroundStyle(.white)
                .scaleEffect(x: -1, y: 1)
                .rotationEffect(.degrees(-12))
        }
    }
}

/// 自訂繪製的「VIP」星星勳章與底部雙緞帶圖示
struct VIPRibbonIconView: View {
    /// 勳章內顯示的文字（例如：`"VIP"`）
    let label: String

    var body: some View {
        ZStack {
            // 下方左右對稱展開的兩條白色燕尾緞帶
            HStack(spacing: 4) {
                RibbonTailShape()
                    .fill(Color.white.opacity(0.95))
                    .frame(width: 10, height: 18)
                    .rotationEffect(.degrees(18))
                RibbonTailShape()
                    .fill(Color.white.opacity(0.95))
                    .frame(width: 10, height: 18)
                    .scaleEffect(x: -1, y: 1)
                    .rotationEffect(.degrees(-18))
            }
            .offset(y: 12)

            // 上方白色圓形獎章，內部包含珊瑚粉色星星與 VIP 粗體字樣
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 31, height: 31)

                VStack(spacing: 0) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(Color(red: 0.90, green: 0.36, blue: 0.39))
                    Text(label)
                        .font(.system(size: 9.5, weight: .black))
                        .foregroundStyle(Color(red: 0.90, green: 0.36, blue: 0.39))
                }
            }
            .offset(y: -4)
        }
    }
}

/// 勳章下方的燕尾型緞帶幾何形狀（底部中央具有倒 V 型缺口）
struct RibbonTailShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        // 緞帶底部中央向上內凹的燕尾頂點
        path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.72))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}
