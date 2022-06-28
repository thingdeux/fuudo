//
//  UpcomingView.swift
//  fuudo

import SwiftUI
import fuudoAPI

struct UpcomingView: View {
    @ObservedObject var viewModel: UpcomingViewModel
    
    init(scheduleService: ScheduleService, orderProcessor: OrderProcessor) {
        self.viewModel = UpcomingViewModel(using: scheduleService, orderProcessor: orderProcessor)
    }
    
    private var zippedOfferings: [(Int, UpcomingViewModel.TitledWeekSchedule)] {
        return Array(zip(viewModel.upcomingOfferings.indices, viewModel.upcomingOfferings))
    }
    
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea(.container, edges: .vertical)
            
            ProgressView()
                .colorScheme(.dark)
                .preferredColorScheme(.dark)
                .scaleEffect(1.5)
                .opacity(viewModel.isLoading ? 1 : 0)
                        
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach(zippedOfferings, id: \.1.sectionTitle) { index, scheduledWeek in
                        VStack {
                            HStack {
                                Text("\(scheduledWeek.sectionTitle)")
                                    .foregroundColor(Color.lightPrimaryColor)
                                    .font(.custom(Font.bookBoldName, size: 40, relativeTo: .title))
                                    .bold()
                                    .padding()
                                Spacer()
                            }
                                         
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(scheduledWeek.1, id: \.self) { offering in
                                        UpcomingItemView(
                                            item: offering,
                                            dayOfTheWeekLetter: offering.dayOfTheWeekLetter
                                        )
                                    }
                                }
                                .padding()
                            }
                        }
                        // Staggered slides
                        .transition(
                            .move(edge: index % 2 == 0 ? .leading : .trailing)
                        )
                    }
                }
            }
            .opacity(viewModel.isLoading ? 0 : 1)
        }
        .task {            
            await viewModel.onAppear()
        }
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView(
            scheduleService: Mocks.scheduleService,
            orderProcessor: Mocks.orderProcessesor
        )
    }
}
