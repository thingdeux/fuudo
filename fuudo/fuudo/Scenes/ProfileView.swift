//
//  ProfileView.swift
//  fuudo

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.lightBackgroundColor
            
            VStack {
                Text("Profile View")
                    .font(.custom(Font.bookBoldName, size: 26, relativeTo: .title2))
                    .foregroundColor(Color.primaryTextColor)
                
                Text("Cutting Room Floor")
                    .font(.custom(Font.bookBoldName, size: 26, relativeTo: .title2))
                    .foregroundColor(Color.primaryTextColor)
                
                Text("🥹")
                    .font(.largeTitle)
                
                Text("🙏🏽")
                    .font(.title)
                    .offset(x: 0, y: -16)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
