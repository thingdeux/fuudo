//
//  FuudoApp.swift
//  fuudo

import SwiftUI

@main
struct FuudoApp: App {
    @State private(set) var isBootstrapping = true
    
    var body: some Scene {
        WindowGroup {
            appContainer()
                .task {
                    setupCoreUIElements()
                    await Injection.current.setup()
                    
                    // Wait for a couple of seconds - we'll pretend the API is communicating.
                    let threeSecondsInNanoSeconds: UInt64 = 3_000_000_000 / 3
                    try? await Task.sleep(nanoseconds: threeSecondsInNanoSeconds)
                    
                    DispatchQueue.main.async {
                        withAnimation {
                            isBootstrapping = false
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    private func appContainer() -> some View {
        if isBootstrapping {
            ZStack {
                Color.primaryColor
                    .ignoresSafeArea(.container, edges: .all)
                
                ProgressView()
                    .colorScheme(.dark)
                    .preferredColorScheme(.dark)
                    .scaleEffect(1.5)
            }
            .transition(.opacity)
        } else {
            BaseContainerView()
                .transition(.opacity)
        }
    }
    
    private func setupCoreUIElements() {
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor(Color.lightBackgroundColor)
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.lightPrimaryColor)
            UITabBar.appearance().standardAppearance = tabBarAppearance

            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
                
    }
}
