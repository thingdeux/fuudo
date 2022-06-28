//
//  User.swift
//

import Foundation

public struct User {
    public let name: String
    public let avatarUrl: URL?
    public let dietaryRequirements: Set<DietaryNeed>
    
    public static var standardUser: User = User(name: "Fuudo User", avatarUrl: nil, dietaryRequirements: Set<DietaryNeed>())
}
