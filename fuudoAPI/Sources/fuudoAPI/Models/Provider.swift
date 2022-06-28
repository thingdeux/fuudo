//
//  Provider.swift
//

import Foundation
import SwiftUI

public struct Provider {
    public let name: String
    public let productsOffered: [Product]
    // Don't love this - should be some image url for a remote image 😡
    public let promoImage: Image?
    
    public init(name: String, productsOffered: [Product], promoImage: Image?) {
        self.name = name
        self.productsOffered = productsOffered
        self.promoImage = promoImage
    }
}

extension Provider: Hashable, Equatable {
  public static func == (lhs: Provider, rhs: Provider) -> Bool {
    return lhs.name == rhs.name &&
      lhs.productsOffered == rhs.productsOffered
  }
    
  public func hash(into hasher: inout Hasher) {
    hasher.combine(name)
    hasher.combine(productsOffered)
  }
}
