//
//  OrderBadgeView.swift
//  fuudo

import SwiftUI

struct OrderBadgeView: View {
    let item: BadgeDisplayable
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.lightBackgroundColor)
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Your Order")
                            .foregroundColor(Color.primaryTextColor)
                            .bold()
                            .font(.custom(Font.bookBoldName, size: 20, relativeTo: .title2))
                            .padding([.leading, .top], 10)
                        Spacer()
                    }
                    
                    HStack(alignment: .centerToCenter) {
                        // Push the view to right
                        Spacer()
                            
                        CenteredBadgeMetadataView(item: item)
                            .frame(width: proxy.size.width * 0.65)
                            .alignmentGuide(.centerToCenter) { dimensions in
                                dimensions[VerticalAlignment.center]
                            }
                            .offset(x: 10, y: 0)
                            
                        Image(systemName: "chevron.right")
                            .renderingMode(.template)
                            .scaleEffect(1.5)
                            .foregroundColor(Color.primaryColor)
                            .padding()
                            .alignmentGuide(.centerToCenter) { dimensions in
                                dimensions[VerticalAlignment.center] + 10
                            }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

private struct CenteredBadgeMetadataView: View {
    let item: BadgeDisplayable
    
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .center, spacing: 4) {
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(item.titleText)")
                        // Really tight spacing here to allow for long names.
                        .kerning(0.25)
                        .foregroundColor(Color.primaryTextColor)
                        .font(.custom(Font.bookBoldName, size: 20, relativeTo: .title3))
                        .bold()
                        // TIGHT TIGHT TIGHT
                        .lineSpacing(-16)
                        .lineLimit(2)
                        .multilineTextAlignment(.trailing)
                        .minimumScaleFactor(0.6)
                    
                    Text(item.bodyText ?? "")
                        // Really tight spacing here to allow for long names.
                        .kerning(0.15)
                        .foregroundColor(Color.primaryTextColor.opacity(0.75))
                        .font(.custom(Font.bookRegularName, size: 16, relativeTo: .subheadline))
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .alignmentGuide(VerticalAlignment.center) { dimensions in
                    dimensions[VerticalAlignment.center] - 4
                }
                .padding(.trailing, 6)
                                    
                CircularImageView(image: item.image)
                    .frame(width: proxy.size.width * 0.32)
            }
        }
    }
}

struct OrderBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea(.container, edges: .vertical)
            
            OrderBadgeView(item: Mocks.mockProduct)
                .frame(height: 120)
                .padding()
        }
    }
}
