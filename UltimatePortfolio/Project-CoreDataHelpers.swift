//
//  Project-CoreDataHelpers.swift
//  UltimatePortfolio
//
//  Created by Mark Townsend on 11/11/20.
//

import SwiftUI

extension Project {
    var projectTitle: String {
        title ?? NSLocalizedString("New Project", comment: "Create a new project")
    }

    var projectDetail: String {
        detail ?? ""
    }

    var projectColor: String {
        color ?? Project.defaultColor
    }

    var projectItems: [Item] {
        items?.allObjects as? [Item] ?? []
    }

    var projectItemsDefaultSorted: [Item] {
        return projectItems.sorted { first, second in
            if first.completed == false {
                if second.completed == true {
                    return true
                }
            } else if first.completed == true {
                if second.completed == false {
                    return false
                }
            }

            if first.priority > second.priority {
                return true
            } else if first.priority < second.priority {
                return false
            }

            return first.itemCreationDate < second.itemCreationDate
        }
    }

    var completionAmount: Double {
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0 }

        let completedItems = originalItems.filter(\.completed)
        return Double(completedItems.count) / Double(originalItems.count)
    }

    var label: LocalizedStringKey {
        LocalizedStringKey("\(projectTitle), \(projectItems.count) items, \(completionAmount * 100, specifier: "%g")% complete.")
    }

    static let colors = ["Pink", "Purple", "Red", "Orange", "Gold", "Green", "Teal", "Light Blue", "Dark Blue", "Midnight", "Dark Gray", "Gray"]
    static let defaultColor = "Light Blue"
    
    static var example: Project {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let project = Project(context: viewContext)
        project.title = "Example Project"
        project.detail = "This is an example project"
        project.closed = true
        project.creationDate = Date()
        return project
    }

    func projectItems<Value: Comparable>(sortedBy keyPath: KeyPath<Item, Value>) -> [Item] {
        projectItems.sorted {
            $0[keyPath: keyPath] < $1[keyPath: keyPath]
        }
    }

    func projectItems(using sortOrder: Item.SortOrder) -> [Item] {
        switch sortOrder {
        case .title:
            return projectItems(sortedBy: \Item.itemTitle)
        case .creationDate:
            return projectItems(sortedBy: \Item.itemCreationDate)
        case .optimized:
            return projectItemsDefaultSorted
        }
    }
}
