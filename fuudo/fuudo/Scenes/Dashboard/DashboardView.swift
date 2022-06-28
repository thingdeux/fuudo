//
//  DashboardView.swift
//

import SwiftUI
import fuudoAPI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    init(scheduleService: ScheduleService, orderProcessor: OrderProcessor) {
        self.viewModel = DashboardViewModel(using: scheduleService, orderProcessor: orderProcessor)
    }
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea(.container, edges: .vertical)
            
            activeView()
                .task {
                    await viewModel.onAppear()
                }
        }
    }
    
    @ViewBuilder
    private func activeView() -> some View {
        if viewModel.isWeekend {
            VStack {
                Text("Get some rest it's the weekend!")
                    .font(.custom(Font.bookBoldName, size: 20, relativeTo: .title))
                    .foregroundColor(Color.lightBackgroundColor)
                    .bold()
                    .padding(.bottom)
                
                Image(systemName: "zzz")
                    .renderingMode(.template)
                    .font(.title)
                    .scaleEffect(1.5)
                    .foregroundColor(Color.lightBackgroundColor)
            }
            
        } else {
            VStack(spacing: 0) {
                SimpleHeader()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 0) {
                        SchedulePeek(
                            today: viewModel.todaysOffering,
                            tomorrow: viewModel.tomorrowsOffering
                        )
                        .transition(.slide)
                        .frame(height: 160)
                        .padding([.bottom, .top])
                        
                        Rectangle()
                            .fill(Color.badgeColor)
                            .frame(height: 1)
                            .padding([.bottom])
                        
                        if let order = viewModel.orderDetails {
                            NavigationLink {
                                ProductDetailView(product: order.products.first! as BadgeDisplayable)
                                    .navigationTitle("\(order.titleText)")
                            } label: {
                                OrderBadgeView(item: order)
                                    .transition(.slide)
                                    .frame(height: 120)
                            }
                        }
                        // TODO: Should be a default ("Don't forget to place your order") state.
                        // Bah '.... wasn't able to get the order functionality in :(
                    }
                    .padding(.horizontal)
                    
                }
            }
        }
    }
}

private struct SimpleHeader: View {
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
               .fill(Color.primaryColor)
               .frame(height: 28)
               .overlay {
                   HStack {
                       Text("Home")
                           .font(.custom(Font.bookBoldName, size: 20, relativeTo: .body))
                           .bold()
                           .foregroundColor(Color.lightBackgroundColor)
                           .padding([.leading], 8)
                           .padding(.bottom)
                       
                       Spacer()
                   }
               }
            
            // Create visual border / "Lip" that a scroll view can scroll under
            Rectangle()
                .fill(Color.gray.opacity(0.050))
                .frame(height: 1)
        }
    }
}

private struct SchedulePeek: View {
    let today: BadgeDisplayable?
    let tomorrow: BadgeDisplayable?
    private let halfOfTheScreenWithSpaceForPadding: CGFloat = 0.48
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                
                if let today = today {
                    AccentedImageBadge(title: "Today", item: today)
                        .frame(width: proxy.size.width * halfOfTheScreenWithSpaceForPadding)
                }
                
                if let tomorrow = tomorrow {
                    Spacer()
                    AccentedImageBadge(title: "Tomorrow", item: tomorrow)
                        .frame(width: proxy.size.width * halfOfTheScreenWithSpaceForPadding)
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(
            scheduleService: Mocks.scheduleService,
            orderProcessor: Mocks.orderProcessesor
        )
    }
}
