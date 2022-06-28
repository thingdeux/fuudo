//
//  ProviderConstants.swift
//
//  This file contains lots of static data that describes products (Food / Condiments / Drinks / Desserts...etc)
//
//  Note: These would, ideally be provided by some API and not be stored locally as constants in the app.
//

import Foundation

enum ProviderConstants {
    
    // TODO: Would like to have promoImage's for each of these providers
    // These product offerings are a bit weighty - pulling them out for cleaner maintenance.
    private static let standardDrinks: [Product] = [ProductConstants.Pepsi, ProductConstants.Lemonade, ProductConstants.Water]
    private static let breakfastItems: [Product] = [ProductConstants.BacondAndEggs, ProductConstants.BreakfastSausage, ProductConstants.ScrambledEggs, ProductConstants.Bagel,
                                                             ProductConstants.SalsaFresca, ProductConstants.Ketchup, ProductConstants.Waffle, ProductConstants.WheatToast,
                                                             ProductConstants.LoxSpread, ProductConstants.CreamCheeseSpread]
    
    private static let hamburgerItems: [Product] = [ProductConstants.Cheeseburger, ProductConstants.Hamburger, ProductConstants.Fries,
                                                             ProductConstants.Ketchup, ProductConstants.Mustard, ProductConstants.Pickles,
                                                             ProductConstants.Chili]
            
    private static let pizzaItems: [Product] = [ProductConstants.CheesePizza, ProductConstants.PepperoniPizza, ProductConstants.RedPeppers, ProductConstants.ParmesanCheese]
    private static let sandwichItems: [Product] = [ProductConstants.HamSandwich, ProductConstants.TurkeySandwich, ProductConstants.Fries, ProductConstants.SlicedTomatoes,
                                                            ProductConstants.Pickles, ProductConstants.Mayo, ProductConstants.Mustard, ProductConstants.Chips]
    
    
    // MARK: Restaurants
    static let ChickenGrill: Provider = Provider(name: "Chicken Grill Ltd.",
                                                 productsOffered: [ProductConstants.ChickenAndWaffles, ProductConstants.FriedChicken, ProductConstants.Waffle] + standardDrinks,
                                                 promoImage: nil)
    
    static let TacoTinas: Provider = Provider(name: "Taco Tinas",
                                              productsOffered: [ProductConstants.Tacos, ProductConstants.DairyFreeTacos,
                                                                    ProductConstants.SalsaFresca, ProductConstants.Flan] + standardDrinks, promoImage: nil)
    
    static let CurryShoppe: Provider = Provider(name: "Curry Shoppe",
                                                productsOffered: [ProductConstants.TikkaMasalaCurry, ProductConstants.BaltiCurry, ProductConstants.MadrasCurry] + standardDrinks,
                                                promoImage: nil)
    
    static let PizzaPalace: Provider = Provider(name: "Pizza Palace",
                                                productsOffered: pizzaItems + standardDrinks,
                                                promoImage: nil)
    
    static let SushiSams: Provider = Provider(name: "Sushi Sams",
                                              productsOffered: [ProductConstants.Sushi, ProductConstants.Wasabi] + standardDrinks,
                                              promoImage: nil)
    
    static let BreakfastBistro: Provider = Provider(name: "Bobs Breakfast Bistro",
                                              productsOffered: breakfastItems + standardDrinks,
                                                    promoImage: nil)
    
    static let HamburgerHannahs: Provider = Provider(name: "Hamburger Hannahs", productsOffered: hamburgerItems + standardDrinks, promoImage: nil)
    
    static let SpaghettiSpa: Provider = Provider(name: "Spaghetti Spa",
                                                 productsOffered: [ProductConstants.Spaghetti, ProductConstants.RedPeppers, ProductConstants.ParmesanCheese] + standardDrinks,
                                                 promoImage: nil)
    
    static let FranklinFishFare: Provider = Provider(name: "Franklin Fish Fare",
                                                     productsOffered: [ProductConstants.Salmon, ProductConstants.Fries] + standardDrinks,
                                                     promoImage: nil)
    
    static let SauronsSandwichSupply: Provider = Provider(name: "Saurons Sandwich Supply",
                                                          productsOffered: [ProductConstants.HamSandwich, ProductConstants.TurkeySandwich, ProductConstants.Fries] + standardDrinks,
                                                          promoImage: nil)
    
    
    /*
     * First Week
     * Monday->Chicken-and-waffles
     * Tuesday->Tacos
     * Wednesday->Curry
     * Thursday->Pizza
     * Friday->Sushi

     * Second Week
     * Monday->Breakfast-for-lunch
     * Tuesday->Hamburgers
     * Wednesday->Spaghetti
     * Thursday->Salmon
     * Friday->Sandwiches
    */

    // MARK: Static Provider Mappings
    static let weekOne: [Provider] = [
        ChickenGrill, TacoTinas, CurryShoppe, PizzaPalace, SushiSams
    ]
    
    static let weekTwo: [Provider] = [
        BreakfastBistro, HamburgerHannahs, SpaghettiSpa, FranklinFishFare, SauronsSandwichSupply
    ]
}
