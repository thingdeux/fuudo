//
//  fuudoAPI.swift
//

public protocol FuudoAPIProvider {
    var schedulerService: ScheduleService { get }
    var orderProcessor: OrderProcessor { get }
    func rate(product: Product, rating: Int)
}

public class FuudoAPI: FuudoAPIProvider {
    private(set) public var schedulerService: ScheduleService
    private(set) public var orderProcessor: OrderProcessor
    
    // Make sure to hide all implementation details and simply return protocol instances to consumers.
    // Promote no concrete contracts and allow for hot-swapping underlying implementations.
    public static func initialize() async -> FuudoAPIProvider {
        let api = FuudoAPI()
        await api.schedulerService.setup()
        return api
    }
    
    // These would likely be stored in some offsite repository - just a quick and dirty implementation.
    private var productRatings: [Product: Int] = [:]
        
    fileprivate init(scheduler: ScheduleService? = nil, orderProcessor: OrderProcessor? = nil) {
        self.schedulerService = scheduler ?? FuudoScheduler()
        self.orderProcessor = orderProcessor ?? FuudoOrderProcessor()
        
        Task.init {
            await self.schedulerService.setup()
        }
    }
    
    public func rate(product: Product, rating: Int) {
        // No point in setting a rating of 0 - basically a no-op
        guard rating > 0 else { return }
        let rating: Int = rating > 5 ? 5 : rating
        productRatings.updateValue(rating, forKey: product)
    }
}
