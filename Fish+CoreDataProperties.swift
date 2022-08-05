//
//  Fish+CoreDataProperties.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.8.2022.
//
//

import Foundation
import CoreData


extension Fish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fish> {
        return NSFetchRequest<Fish>(entityName: "Fish")
    }

    @NSManaged public var details: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?

}

extension Fish : Identifiable {

}
