import SwiftUI

struct TopBarView: View {
    let logoImageName: String
    let activeCategory: String
    let secondaryCategory: String

    var body: some View {
        VStack(spacing: 14) {
            // Top Logo & Action Icons Row
            HStack(alignment: .center) {
                Image(logoImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 36)

                Spacer()

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

            // Category Switcher & Sort Icon Row
            HStack(alignment: .center, spacing: 18) {
                Text(activeCategory)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(Color(red: 0.12, green: 0.12, blue: 0.12))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color(red: 0.945, green: 0.945, blue: 0.945))
                    )

                Text(secondaryCategory)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(Color(red: 0.36, green: 0.36, blue: 0.36))

                Spacer()

                SortFilterIconView()
                    .frame(width: 24, height: 18)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 6)
        }
        .background(Color.white)
    }
}

/// Custom Chromecast / AirPlay Cast icon matching the screenshot
struct CastIconView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Outer screen rectangle with bottom-left cutout
            Canvas { context, size in
                let w = size.width
                let h = size.height
                let lineWidth: CGFloat = 2.0

                // Screen frame path (starts above bottom-left waves, goes around top-left, top-right, bottom-right, ends right of waves)
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

                // Bottom-left cast dot + 2 arcs
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

/// Custom Sort / Filter icon (three horizontal bars of decreasing width + up/down triangles on right)
struct SortFilterIconView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 3.5) {
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
