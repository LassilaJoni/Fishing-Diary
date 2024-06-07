//
//  PreviewContainer.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.1.2024.
//

import Foundation
import SwiftData

struct Preview {
    let container: ModelContainer
    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            container = try ModelContainer(for: DataItem.self, configurations: config)
        } catch {
            fatalError("Preview container creation wasn't succesful")
        }
    }
    func addExamples(_ examples: [DataItem]) {
        Task { @MainActor in
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
}
