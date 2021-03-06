//
//  DataController.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer // "capable of managing BOTH CloudKit-backed and noncloud stores"

    init(inMemory: Bool = false) {
        // container = NSPersistentCloudKitContainer(name: "KoyaQuest")
        container = NSPersistentCloudKitContainer(name: "KoyaQuest", managedObjectModel: Self.model)

        // following block added 12-11-21 following apple video tutorial
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("###\(#function): Failed to retrieve persistent store description.")
        }
        description.cloudKitContainerOptions?.databaseScope = .public
//        let publicStoreURL = description.url!.deletingLastPathComponent().appendingPathComponent("KoyaQuest-public.sqlite")
//        let identifier = description.cloudKitContainerOptions!.containerIdentifier
//        let publicDescription = NSPersistentStoreDescription(url: publicStoreURL)
//        publicDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
//        publicDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
//        let publicOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: identifier)
//        publicOptions.databaseScope = .public
//        publicDescription.cloudKitContainerOptions = publicOptions
//        container.persistentStoreDescriptions.append(publicDescription)
        // END of new lines (from 12-11-21)


        // container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        if inMemory { // write to a dead zone
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        // container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Fatal error loading data store: \(error.localizedDescription)")
            }

#if DEBUG
            if CommandLine.arguments.contains("enable-testing") {
                self.deleteAll()
                UIView.setAnimationsEnabled(false)
            }
#endif
        }


    }

    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        // let viewContext = dataController.container.viewContext
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }
        return dataController
    }()

    static let model: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "KoyaQuest", withExtension: "momd") else {
            fatalError("Failed to locate model.")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load model file.")
        }
        return managedObjectModel
    }()

    func createSampleData() throws { // create sample data
        let viewContext = container.viewContext
        for index in 1...10 {
            let rating = Rating(context: viewContext)
            rating.landmark = Landmark.allLandmarks[index].name
            rating.rating = Int16.random(in: 1...5)
            rating.date = Date()
        }
        try viewContext.save()
    }
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }

    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }

    func deleteAll() { // for testing only
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Rating.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)
    }

    func count<T>(for fetchRequest: NSFetchRequest<T>) -> Int {
        (try? container.viewContext.count(for: fetchRequest)) ?? 0
    }
}
