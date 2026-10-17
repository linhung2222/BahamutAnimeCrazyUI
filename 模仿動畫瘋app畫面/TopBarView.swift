import SwiftUI

/// 頂部固定導覽列視圖
/// 包含第一列的「巴哈姆特動畫瘋 Logo、無線投影（Cast）與搜尋按鈕」，以及第二列的「本季新番／週期表分類切換與排序篩選圖示」
struct TopBarView: View {
    /// Assets 中的品牌 Logo 圖片名稱
    let logoImageName: String
    /// 目前選中的主分類名稱（例如：「本季新番」）
    let activeCategory: String
    /// 次要分類名稱（例如：「週期表」）
    let secondaryCategory: String

    var body: some View {
        VStack(spacing: 14) {
            // 第一列：左側動畫瘋 Logo 與右側功能圖示（投影、搜尋）
            HStack(alignment: .center) {
                // 巴哈姆特動畫瘋品牌 Logo
                Image(logoImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 36)

                Spacer()

                // 右上角操作按鈕群組：無線投影（Chromecast / AirPlay）與放大鏡搜尋圖示
                HStack(spacing: 20) {
                    CastIconView()
                        .frame(width: 24, height: 20)
                        .foregroundStyle(Color(red: 0.22, green: 0.22, blue: 0.22))

                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 21, weight: .semibold))
                        .foregroundStyle(Color(red: 0.22, green: 0.22, blue: 0.22))
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 6)

            // 第二列：分類切換標籤（「本季新番」、「週期表」）與右側排序篩選圖示
            HStack(alignment: .center, spacing: 18) {
                // 選中狀態的分類膠囊按鈕（淺灰圓角底色）
                Text(activeCategory)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(Color(red: 0.12, green: 0.12, blue: 0.12))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color(red: 0.945, green: 0.945, blue: 0.945))
                    )

                // 未選中狀態的次要分類文字
                Text(secondaryCategory)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(Color(red: 0.36, green: 0.36, blue: 0.36))

                Spacer()

                // 右側排序與篩選圖示
                SortFilterIconView()
                    .frame(width: 24, height: 18)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 6)
        }
        .background(Color.white)
    }
}

/// 自訂繪製的電視無線投影（Chromecast / AirPlay）向量圖示
/// 使用 SwiftUI `Canvas` 與 `Path` 描繪外框與左下角無線電波弧線
struct CastIconView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // 使用 Canvas 手繪外框與左下角訊號波紋
            Canvas { context, size in
                let w = size.width
                let h = size.height
                let lineWidth: CGFloat = 2.0

                // 螢幕外框路徑（避開左下角的訊號波紋區域，從左側中段往上繞過左上、右上、右下角）
                var framePath = Path()
                framePath.move(to: CGPoint(x: 1, y: h * 0.35))
                framePath.addLine(to: CGPoint(x: 1, y: 3))
                framePath.addQuadCurve(to: CGPoint(x: 3, y: 1), control: CGPoint(x: 1, y: 1))
                framePath.addLine(to: CGPoint(x: w - 3, y: 1))
                framePath.addQuadCurve(to: CGPoint(x: w - 1, y: 3), control: CGPoint(x: w - 1, y: 1))
                framePath.addLine(to: CGPoint(x: w - 1, y: h - 3))
                framePath.addQuadCurve(to: CGPoint(x: w - 3, y: h - 1), control: CGPoint(x: w - 1, y: h - 1))
                framePath.addLine(to: CGPoint(x: w * 0.56, y: h - 1))

                context.stroke(
                    framePath,
                    with: .color(Color(red: 0.22, green: 0.22, blue: 0.22)),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
                )

                // 左下角投影訊號原點與兩道同心圓弧波紋
                let origin = CGPoint(x: 1.5, y: h - 1.5)
                let dotRect = CGRect(x: origin.x - 1, y: origin.y - 2, width: 2.5, height: 2.5)
                context.fill(Path(ellipseIn: dotRect), with: .color(Color(red: 0.22, green: 0.22, blue: 0.22)))

                for radius in [CGFloat(5.2), CGFloat(9.2)] {
                    var arc = Path()
                    arc.addArc(
                        center: origin,
                        radius: radius,
                        startAngle: .degrees(-90),
                        endAngle: .degrees(0),
                        clockwise: false
                    )
                    context.stroke(
                        arc,
                        with: .color(Color(red: 0.22, green: 0.22, blue: 0.22)),
                        style: StrokeStyle(lineWidth: 1.9, lineCap: .round)
                    )
                }
            }
        }
    }
}

/// 自訂繪製的排序／篩選圖示
/// 左側為三條由長到短的水平膠囊線條，右側為上下雙向三角形箭頭
struct SortFilterIconView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 3.5) {
            // 左側三條遞減寬度的水平橫線
            VStack(alignment: .leading, spacing: 3.5) {
                Capsule()
                    .fill(Color(red: 0.22, green: 0.22, blue: 0.22))
                    .frame(width: 12, height: 2)
                Capsule()
                    .fill(Color(red: 0.22, green: 0.22, blue: 0.22))
                    .frame(width: 9, height: 2)
                Capsule()
                    .fill(Color(red: 0.22, green: 0.22, blue: 0.22))
                    .frame(width: 6, height: 2)
            }

            // 右側上下實心小三角形指摽
            VStack(spacing: 3) {
                Image(systemName: "arrowtriangle.up.fill")
                    .font(.system(size: 5.5))
                    .foregroundStyle(Color(red: 0.22, green: 0.22, blue: 0.22))
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.system(size: 5.5))
                    .foregroundStyle(Color(red: 0.22, green: 0.22, blue: 0.22))
            }
        }
    }
}
