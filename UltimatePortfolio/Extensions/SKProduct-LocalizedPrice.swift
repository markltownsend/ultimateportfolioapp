//
//  SKProduct-LocalizedPrice.swift
//  UltimatePortfolio
//
//  Created by Mark Townsend on 7/20/21.
//

import Foundation
import StoreKit

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}
