//
//  DevelopmentTests.swift
//  UltimatePortfolioTests
//
//  Created by Mark Townsend on 5/5/21.
//

import XCTest
import CoreData
@testable import UltimatePortfolio

class DevelopmentTests: BaseTestCase {
    func test_sampleDataCreationWorks() throws {
        try dataController.createSampleData()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 5, "There should be 5 sample projects.")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 50, "There should be 50 sample items.")
    }

    func test_deleteAllClearsEverything() throws {
        try dataController.createSampleData()

        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 0, "deleteAll() should be no projects.")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0, "deleteAll() should be no items.")
    }

    func test_exampleProjectIsClosed() {
        let project = Project.example
        XCTAssertTrue(project.closed, "The example project should be closed.")
    }

    func test_exampleItemIsHighPriority() {
        let item = Item.example
        XCTAssertEqual(item.priority, 3, "The example item should be high priority.")
    }
}
