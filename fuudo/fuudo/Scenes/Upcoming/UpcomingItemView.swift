//
//  UpcomingItemView.swift
//

import SwiftUI

struct UpcomingItemView: View {
    let item: BadgeDisplayable
    let dayOfTheWeekLetter: Character
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.lightBackgroundColor)
                .padding(3)
                        
            DayOfTheWeekBadgeView(dayOfTheWeekLetter: dayOfTheWeekLetter)
                // A *bit* hacky ... would probably just create a path for this instead
                // But...time.
                .position(x: -35, y: -25)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .trailing, spacing: 0) {
                Spacer()
                
                if let image = item.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                        .padding(.trailing)
                    
                }
                    
                HStack {
                    Text(item.titleText)
                        .bold()
                        .foregroundColor(Color.primaryTextColor)
                        .font(.custom(Font.bookBoldName, size: 16, relativeTo: .headline))
                        .kerning(-0.8)
                        .lineSpacing(0)
                        .lineLimit(1)
                        .multilineTextAlignment(.trailing)
                        .padding([.bottom, .horizontal])
                }
            }
        }
        .frame(width: 160, height: 140)
    }
}

private struct DayOfTheWeekBadgeView: View {
    let dayOfTheWeekLetter: Character
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("WeekBadgeColor"))
                .padding(3)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("\(dayOfTheWeekLetter.description.uppercased())")
                        .foregroundColor(Color.lightPrimaryColor)
                        .font(.custom(Font.bookBoldName, size: 20, relativeTo: .title))
                        .bold()
                        .padding()
                        .offset(x: 0, y: 8)
                }
            }
        }
        .clipped()
    }
}

struct UpcomingItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea(.container, edges: .vertical)
            
            HStack {
                UpcomingItemView(item: Mocks.mockProduct, dayOfTheWeekLetter: "M")
                UpcomingItemView(item: Mocks.mockProduct, dayOfTheWeekLetter: "T")
            }
        }
    }
}
