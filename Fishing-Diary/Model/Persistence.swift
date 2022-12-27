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
        for _ in 0..<10 {
            let newItem = Fish(context: viewContext)
            newItem.timestamp = Date()
            newItem.id = UUID()
            newItem.title = "Kala mökiltä"
            newItem.details = "Kala saatu mökiltä. jgidfjgiodjgdiorgjdriogjdiogjdriogdjriogdrjgiodjgiodrjgdiogjdgoirdjgdrgiordjgogirdji"
            newItem.specie = "Pike"
            newItem.weight = "5 kg"
            newItem.lat = 12.444
            newItem.long = 12.333
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
