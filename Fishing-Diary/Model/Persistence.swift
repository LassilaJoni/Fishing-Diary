//
//  Persistence.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        for i in 0...10 {
            let newItem = Fish(context: viewContext)
            newItem.timestamp = Date()
            newItem.id = UUID()
            newItem.title = "Lohi"
            newItem.details = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tristique arcu vitae nulla aliquam, ut sodales dolor dignissim. Quisque aliquam purus vitae vulputate scelerisque."
            newItem.weight = "It was something like 5 kg"
            newItem.lat = 55.3781
            newItem.long = 3.4360
        }
        do {
            try viewContext.save()
        } catch {

            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Fishing_Diary")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
