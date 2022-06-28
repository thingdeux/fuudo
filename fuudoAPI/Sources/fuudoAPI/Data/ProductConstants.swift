//
//  ProductConstants.swift
//
//  This file contains lots of static data that describes products (Food / Condiments / Drinks / Desserts...etc)
//
//  Note: These would, ideally be provided by some API and not be stored locally as constants in the app.
//

import Foundation
import SwiftUI

enum ProductConstants {
    
    // MARK: Chicken and/or Waffles
    // Trying to allow for a user to order just the chicken, or the Waffle or the set ... maybe overkill? 😅
    static let FriedChicken: Product = Product(name: "Chicken", type: .food, promoImage: Image("chickenImage"),
                                               ingredients: ["Chicken Breast", "Milk", "Panko"],
                                               dietaryFulfillments: [.paleo])
    
    static let Waffle: Product = Product(name: "Waffle", type: .food, promoImage: Image("wafflesImage"), ingredients: ["Sugar", "Milk"],
                                         dietaryFulfillments: [.lowSodium])
    
    static let ChickenAndWaffles: Product = Product(name: "Chicken and Waffles", type: .food, promoImage: Image("chickenImage"),
                                                    ingredients: FriedChicken.ingredients + Waffle.ingredients,
                                                    dietaryFulfillments: FriedChicken.dietaryFulfillments + Waffle.dietaryFulfillments)
    
    static let MapleSyrup: Product = Product(name: "Syrup", type: .condiment, promoImage: Image("wafflesImage"),
                                             ingredients: ["Maple Syrup"])
    
    static let BlueberrySyrup: Product = Product(name: "Blueberry Syrup", type: .condiment, promoImage: Image("wafflesImage"), ingredients: ["Blueberries", "Syrup"])
    
    // MARK: Tacos
    static let Tacos: Product = Product(name: "Tacos", type: .food, promoImage: Image("tacoImage"),
                                        ingredients: ["Taco Shell", "Tomatoes", "Lettuce", "Salsa Fresca", "Cheddar Cheese"],
                                        dietaryFulfillments: [.shellFishAllergyTolerant])
    
    static let DairyFreeTacos: Product = Product(name: "Tacos", type: .food, promoImage: Image("tacoImage"),
                                                 ingredients: ["Taco Shell", "Tomatoes", "Lettuce", "Salsa Fresca", "Plant-Based Cheese"],
                                                 dietaryFulfillments: [.dairyLactoseFree, .shellFishAllergyTolerant])
    
    static let SalsaFresca: Product = Product(name: "Salsa Fresca", type: .condiment, ingredients: ["Tomatoes", "Peppers"])
    
    static let Flan: Product = Product(name: "Flan", type: .dessert)
    
    
    // MARK: Curry
    static let BaltiCurry: Product = Product(name: "Balti Curry", type: .food, promoImage: Image("curryImage"), dietaryFulfillments: [.vegetarian])
    static let MadrasCurry: Product = Product(name: "Madras Curry", type: .food, promoImage: Image("curryImage"), dietaryFulfillments: [.vegan])
    
    static let TikkaMasalaCurry: Product = Product(name: "Tikka Masala Curry", type: .food, promoImage: Image("curryImage"))
    
    // MARK: Pizza
    static let CheesePizza: Product = Product(name: "Cheese Pizza", type: .food, promoImage: Image("pizzaImage"), ingredients: ["Cheese", "Marina Sauce", "Pizza Dough"],
                                              dietaryFulfillments: [.vegetarian])
    
    static let PepperoniPizza: Product = Product(name: "Cheese Pizza", type: .food, promoImage: Image("pizzaImage"),
                                                 ingredients: ["Pepperoni", "Cheese", "Marina Sauce", "Pizza Dough"])

    static let RedPeppers: Product = Product(name: "Red Peppers", type: .condiment, promoImage: Image("condimentImage"), ingredients: ["Red Peppers"])
    
    
    // MARK: Sushi
    static let Sushi: Product = Product(name: "Sushi", type: .food, promoImage: Image("sushiImage"))
    static let Wasabi: Product = Product(name: "Wasabi", type: .condiment, promoImage: Image("sushiImage"), ingredients: ["Wasabi"])
    
    // MARK: Breakfast
    static let BacondAndEggs: Product = Product(name: "Bacon and Eggs", type: .food, promoImage: Image("baconAndEggsImage"), ingredients: ["Bacon", "Eggs"])
    static let BreakfastSausage: Product = Product(name: "Breakfast Sausage", type: .food, ingredients: ["Sausage"])
    static let Bagel: Product = Product(name: "Bagel", type: .food, promoImage: Image("condimentImage"), ingredients: ["Bagel"])
    static let Hashbrowns: Product = Product(name: "Hashbrowns", type: .food, promoImage: Image("condimentImage"), ingredients: ["Potatoes", "Butter"])
    static let LoxSpread: Product = Product(name: "Lox Spread", type: .condiment, promoImage: Image("condimentImage"), ingredients: ["Lox", "Butter", "Cream"])
    static let CreamCheeseSpread: Product = Product(name: "Cream Cheese Spread", type: .condiment, promoImage: Image("condimentImage"), ingredients: ["Cream Cheese"])
    static let ScrambledEggs: Product = Product(name: "Scrambled Eggs", type: .condiment, promoImage: Image("condimentImage"), ingredients: ["Eggs"])
    static let WheatToast: Product = Product(name: "Toast", type: .condiment, ingredients: ["Wheat Bread"])
    
    // MARK: Steamed Hams
    static let Cheeseburger: Product = Product(name: "Cheeseburger", type: .food, promoImage: Image("burgerImage"),
                                               ingredients: ["American Cheese", "Burger Bun", "Beef Hamburger Patty"])
    static let Hamburger: Product = Product(name: "Hamburger", type: .food, promoImage: Image("burgerImage"),
                                            ingredients: ["Burger Bun", "Beef Hamburger Patty"], dietaryFulfillments: [.paleo])

    static let Ketchup: Product = Product(name: "Ketchup", type: .condiment, promoImage: Image("condimentImage"))
    static let Mustard: Product = Product(name: "Mustard", type: .condiment, promoImage: Image("condimentImage"))
    static let Chili: Product = Product(name: "Chili", type: .condiment, promoImage: Image("condimentImage"))
    static let Fries: Product = Product(name: "Fries", type: .food, dietaryFulfillments: [.vegetarian])
    
    // MARK: Spaghetti
    static let Spaghetti: Product = Product(name: "Spaghetti", type: .food, promoImage: Image("spaghettiImage"),
                                            ingredients: ["Marinara", "Spaghetti Noodles"], dietaryFulfillments: [.vegetarian])

    static let ParmesanCheese: Product = Product(name: "Parmesan Cheese", type: .food, ingredients: ["Cheese"], dietaryFulfillments: [.vegetarian])
    
    // MARK: Salmon
    static let Salmon: Product = Product(name: "Salmon", type: .food, promoImage: Image("salmonImage"),
                                         ingredients: ["Wild Caught Salmon"], dietaryFulfillments: [.lowSodium, .keto])
    
    // MARK: Sandwiches
    static let HamSandwich: Product = Product(name: "Ham Sandwich", type: .food, promoImage: Image("sandwichImage"),
                                         ingredients: ["Ham", "Wheat Bread"], dietaryFulfillments: [.lowSodium, .dairyLactoseFree])
    
    static let TurkeySandwich: Product = Product(name: "Turkey Sandwich", type: .food, promoImage: Image("sandwichImage"),
                                                 ingredients: ["Ham", "Wheat Bread"], dietaryFulfillments: [.lowSodium, .dairyLactoseFree])
    
    static let Mayo: Product = Product(name: "Mayo", type: .condiment, promoImage: Image("condimentImage"))
    static let Pickles: Product = Product(name: "Pickles", type: .condiment, promoImage: Image("condimentImage"))
    static let SlicedTomatoes: Product = Product(name: "SlicedTomatoes", type: .condiment, promoImage: Image("condimentImage"))
    
    
    // MARK: Snacks
    static let Chips: Product = Product(name: "Chips", type: .snack, ingredients: ["Potato", "Peanut Oil"])
    
    // MARK: Drinks
    static let Pepsi: Product = Product(name: "Pepsi", type: .drink, promoImage: Image("drinkImage"), ingredients: ["Secrets", "Sunshine", "Freedom"])
    static let Lemonade: Product = Product(name: "Lemonade", type: .drink, promoImage: Image("drinkImage"), ingredients: ["Lemons", "Sugar"])
    static let Water: Product = Product(name: "Water", type: .drink, promoImage: Image("drinkImage"), ingredients: ["Water"])
}
