//
//  CloudError.swift
//  UltimatePortfolio
//
//  Created by Mark Townsend on 9/29/21.
//

import SwiftUI

struct CloudError: Identifiable, ExpressibleByStringInterpolation {
    var id: String { message }
    var message: String

    var localizedMessage: LocalizedStringKey {
        LocalizedStringKey(message)
    }
    init(stringLiteral value: String) {
        self.message = value
    }
}
