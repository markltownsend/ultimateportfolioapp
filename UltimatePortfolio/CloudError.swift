//
//  CloudError.swift
//  UltimatePortfolio
//
//  Created by Mark Townsend on 9/29/21.
//

import Foundation

struct CloudError: Identifiable, ExpressibleByStringInterpolation {
    var id: String { message }
    var message: String
    
    init(stringLiteral value: String) {
        self.message = value
    }
}
