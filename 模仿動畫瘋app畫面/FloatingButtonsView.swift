import SwiftUI

struct FloatingButtonsView: View {
    let infoLabel: String
    let vipLabel: String
    let circleDiameter: CGFloat

    var body: some View {
        VStack(spacing: 12) {
            // Cyan "新番情報" Button with Red Dot
            ZStack(alignment: .topTrailing) {
                ZStack {
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

                    VStack(spacing: 2) {
                        MegaphoneIconView()
                            .frame(width: 30, height: 22)
                        Text(infoLabel)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    .offset(y: 1)
                }

                // Red Notification Badge Dot
                Circle()
                    .fill(Color(red: 0.96, green: 0.26, blue: 0.21))
                    .frame(width: 11, height: 11)
                    .offset(x: -2, y: 2)
            }

            // Pink/Coral "VIP" Button
            ZStack {
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

                VIPRibbonIconView(label: vipLabel)
                    .frame(width: 38, height: 46)
                    .offset(y: 2)
            }
        }
    }
}

/// Custom Megaphone icon with sound lines on the left, matching the screenshot's 新番情報 icon
struct MegaphoneIconView: View {
    var body: some View {
        HStack(spacing: 3) {
            // 3 sound lines on the left
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

            // Megaphone cone facing left
            Image(systemName: "megaphone.fill")
                .font(.system(size: 19, weight: .bold))
                .foregroundStyle(.white)
                .scaleEffect(x: -1, y: 1)
                .rotationEffect(.degrees(-12))
        }
    }
}

/// Custom VIP Medal & Ribbon icon matching the screenshot
struct VIPRibbonIconView: View {
    let label: String

    var body: some View {
        ZStack {
            // Two bottom ribbons
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

            // White circular badge with star + VIP text in coral/pink
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

struct RibbonTailShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.72))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}
