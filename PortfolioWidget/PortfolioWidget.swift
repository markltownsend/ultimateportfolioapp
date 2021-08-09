//
//  PortfolioWidget.swift
//  PortfolioWidget
//
//  Created by Mark Townsend on 8/8/21.
//

import WidgetKit
import SwiftUI

@main
struct PortfolioWidgets: WidgetBundle {
    var body: some Widget {
        SimplePortfolioWidget()
        ComplexPortfolioWidget()
    }
}
