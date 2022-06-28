//
//  Injection.swift
//

import Foundation
import fuudoAPI

// Note:
//
// I don't want to bloat the project with an actual D.I. library or definitions
// cheating here and just wrapping some definitions 😅🫣.
// In an actual environment would use some form of D.I to inject these dependencies.
class Injection {
    
    // Allow for what's effectively a 'lateinit' <in Kotlin 🫣>
    // Letting the compiler know this doesn't need to be initialized during init and
    // I am responsible for making sure it's there before someone calls it.
    // swiftlint:disable:next implicitly_unwrapped_optional
    private(set) var sdk: FuudoAPIProvider!
    private(set) static var current: Injection = Injection()
    
    private init() {}
    
    func setup() async {
        sdk = await FuudoAPI.initialize()
    }
}
