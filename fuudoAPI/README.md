# fuudoAPI

The fuudo API will handle all interactions and data modelling that *should* come from a remote data store.  
For the sake of the test mutations against this data store will be stored in memory and likely not persisted to disk [Stretch Goal!]  
Will be an SPM package so that it could be re-used between various targets (ie: if we wanted a watchOS app or want to make a widget [Stretch Goal!!])

#### Services / Interactions

- ScheduleService
    - generateSchedule(ignoringRatings: Bool, skipWeekends: Bool = true) async -> WeeklySchedule
    - getActiveOfferingsForThisWeek() async -> [Schedule.Offering]

- OrderProcessor
    - placeOrder(_ products: [Products], for: ScheduledOffering) // Need to make sure the products match as a validation.
    - getOrder(for: User, offering: ScheduledOffering)

Product.rate(_ rating: Int)    

#### Models

- DietaryNeed
- User
    name
    avatarUrl
    dietaryRequirements: [DietaryNeed]    

- Schedule.Weekly
    offerings: [ScheduledOffering]
        * Helpers for simply getting 'this weeks schedule' and/or 'this weeks schedule filtered by dates that haven't passed.    

- Schedule.Offering
    provider: Provider
    date: Date
    availableBy: Date

- Order
    user
    scheduledOffering
    products: [Product]

- Provider [ex: Subway | Rubys | Food Truck]
    name: String
    promoImage: URL?
    productsOffered: [Product]
    defaultProductSelection: Product   
        Everyone will start out with this product by default and be allowed to choose from other options if the Provider has them.

- Product.Type: Food | Drink | Dessert | Snack | Condiment
- Product
    name: String
    type: Product.Type
    promoImage: URL?            
    ingredients: [String]  // Could expand this if we wanted to have images or metadata related to ingredients then turn it into a type.
    dietaryFullfilments: [DietaryNeed]        
    aggregateRatings: Int
        We're going to use aggregate ratings to help refine Menu generation. ie: Bubble favorites up to the top and drag dislikes.
