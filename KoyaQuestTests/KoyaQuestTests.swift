//
//  KoyaQuestTests.swift
//  KoyaQuestTests
//
//  Created by Kevin K Collins on 2021/07/28.
//
import CoreData
import XCTest
@testable import KoyaQuest

class BaseTestCase: XCTestCase {
    
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
    
}
