//
//  VerticalAlignment+Extensions.swift
//

import Foundation
import SwiftUI

extension VerticalAlignment {
    enum CenterToCenterAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }
    
    static let centerToCenter = VerticalAlignment(CenterToCenterAlignment.self)
}
