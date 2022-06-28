//
//  BaseContainerView.swift
//  fuudo

import SwiftUI

struct BaseContainerView: View {
    var body: some View {
        TabView {
            NavigationView {
                DashboardView(
                    scheduleService: Injection.current.sdk.schedulerService,
                    orderProcessor: Injection.current.sdk.orderProcessor
                )
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "house")
                    .renderingMode(.template)
                    .foregroundColor(Color.lightPrimaryColor)
                
                Text("Home")
                    .font(.custom(Font.bookBoldName, size: 16, relativeTo: .caption))
            }
            
            NavigationView {
                UpcomingView(
                    scheduleService: Injection.current.sdk.schedulerService,
                    orderProcessor: Injection.current.sdk.orderProcessor
                )
                .navigationBarTitle("Upcoming", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "calendar")
                    .renderingMode(.template)
                    .foregroundColor(Color.lightPrimaryColor)
                
                Text("Upcoming")
                    .font(.custom(Font.bookBoldName, size: 16, relativeTo: .caption))
            }
            
            NavigationView {
                ProfileView()
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
            }
            .tabItem {
                Image(systemName: "person")
                    .renderingMode(.template)
                    .foregroundColor(Color.lightPrimaryColor)
                
                Text("Profile")
                    .font(.custom(Font.bookBoldName, size: 16, relativeTo: .caption))
            }
        }
        .accentColor(Color.badgeColor)
        .preferredColorScheme(.dark)
        .colorScheme(.dark)
    }
}

struct BaseContainerView_Previews: PreviewProvider {
    static var previews: some View {
        BaseContainerView()
    }
}
