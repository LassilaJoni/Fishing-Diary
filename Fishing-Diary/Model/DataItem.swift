//
//  DataItem.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 5.1.2024.
//

import Foundation
import SwiftData
import UIKit

@Model
class DataItem: Identifiable {
    var id: String
    var details: String
    var lat: Double
    var long: Double
    var imageData: Data
    var timestamp: Date
    var title: String
    var weight: String
    
    init(details: String, lat: Double, long: Double, imageData: Data, timestamp: Date, title: String, weight: String) {
        self.id = UUID().uuidString
        self.details = details
        self.lat = lat
        self.long = long
        self.imageData = imageData
        self.timestamp = timestamp
        self.title = title
        self.weight = weight
    }
    
    let sampleData: [DataItem] = [
        DataItem(details: "Catched a huge salmon at Lake Superior", lat: 49.8545693, long: -92.1517052, imageData: UIImage(named: "noimagefound")!.jpegData(compressionQuality: 0.5)!, timestamp: Date(), title: "Great Fishing Day!", weight: "15 lbs"),
        DataItem(details: "Spent the afternoon fishing in the creek and caught a few bass and trout", lat: 44.9491143, long: -93.0666019, imageData: UIImage(named: "noimagefound")!.jpegData(compressionQuality: 0.5)!, timestamp: Date(timeIntervalSinceNow: -12 * 60 * 60), title: "Relaxing Fishing Trip", weight: "2 lbs, 3 lbs"),
        DataItem(details: "Was hoping to catch a trophy pike, but only caught a few small ones", lat: 50.3707097, long: -100.344347, imageData: UIImage(named: "noimagefound")!.jpegData(compressionQuality: 0.5)!, timestamp: Date(timeIntervalSinceNow: -24 * 60 * 60), title: "Not the Best Fishing Day", weight: "1 lb, 2 lbs"),
    ]



}

