import SwiftUI

struct AnimeCardView: View {
    let anime: AnimeItem
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    @State private var isFavorited = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Thumbnail with overlays using ZStack
            ZStack {
                Image(anime.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardWidth, height: cardHeight)
                    .clipped()

                // Bottom gradient for readability of views / VIP badge
                VStack {
                    Spacer()
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.65)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 38)
                }

                // Top-right favorite heart icon
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

                // Bottom row: Optional VIP badge on left, Eye + Views on right
                VStack {
                    Spacer()
                    HStack(alignment: .center) {
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

            // Anime Title
            Text(anime.title)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color(red: 0.12, green: 0.12, blue: 0.12))
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(.top, 2)

            // Date/Time and Episode Row
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

/// Custom Material-style filled eye icon with transparent pupil matching Bahamut's view counter icon
struct EyeIconView: View {
    var body: some View {
        ZStack {
            Image(systemName: "eye.fill")
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(.white)
        }
    }
}
