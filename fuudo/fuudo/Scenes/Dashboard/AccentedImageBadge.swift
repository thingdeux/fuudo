//
//  AccentedImageBadge.swift
//  fuudo

import SwiftUI

struct AccentedImageBadge: View {
    let title: String
    let item: BadgeDisplayable
    
    private let badgeSizeScalePercentage: CGFloat = 0.30
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.accentedBackgroundColor)
            
            GeometryReader { proxy in
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(title)
                            .font(.custom(Font.bookBoldName, size: 20, relativeTo: .title))
                            .bold()
                            .foregroundColor(Color.primaryTextColor)
                        Spacer()
                    }
                    
                    Image("restaurantDefaultImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        // NOTE: Cheating a bit here - just want something visually different
                        // and dont' have the time to do this right
                        .blendMode(title.lowercased() == "today" ? .multiply : .difference)
                        .frame(height: proxy.size.height * 0.38)
                        // This image - adjusted for aspect is a bit off center / padded.  Pull left a bit.
                        .alignmentGuide(.leading) { dimensions in
                            dimensions[.leading] + 5
                        }
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(Color.black.opacity(0.5))
                        .frame(height: 1)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Serving")
                            .foregroundColor(Color.primaryTextColor.opacity(0.75))
                            .lineLimit(1)
                            .font(.custom(Font.bookRegularName, size: 16, relativeTo: .subheadline))
                        
                        Text(item.titleText)
                            .foregroundColor(Color.primaryTextColor)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .font(.custom(Font.bookRegularName, size: 16, relativeTo: .subheadline))
                    }
                    .padding(.top, 4)

                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct AccentedImageBadge_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            HStack(spacing: 8) {
                AccentedImageBadge(title: "Today", item: Mocks.mockProvider)
                .frame(
                    width: proxy.size.width * 0.45
                )
                
                AccentedImageBadge(title: "Tomorrow", item: Mocks.mockProvider)
                .frame(
                    width: proxy.size.width * 0.45
                )
            }
            .padding(.horizontal)
            .frame(height: 250)
        }
    }
}
