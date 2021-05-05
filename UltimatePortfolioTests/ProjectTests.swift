//
//  ProjectTests.swift
//  UltimatePortfolioTests
//
//  Created by Mark Townsend on 5/5/21.
//

import XCTest
import CoreData
@testable import UltimatePortfolio

class ProjectTests: BaseTestCase {

    func test_creatingProjectsAndItems() {
        let targetCount = 10
        for _ in 0..<targetCount {
            let project = Project(context: managedObjectContext)

            for _ in 0..<targetCount {
                let item = Item(context: managedObjectContext)
                item.project = project
            }
        }

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), targetCount)
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), targetCount * targetCount)
    }

    // Create sample data, fetch all the projects, delete the first one of them,
    // then assert that we have 4 projects and 40 items remaining.
    func test_deletingProjectCascadeDeletesItems() throws {
        try dataController.createSampleData()
        let request = NSFetchRequest<Project>(entityName: "Project")
        let projects = try managedObjectContext.fetch(request)
        XCTAssertEqual(projects.count, 5)

        dataController.delete(projects[0])
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 4)
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 40)
    }
}
