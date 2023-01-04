//
//  FishAnnotation.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 4.1.2023.
//

import Foundation
import MapKit

struct FishAnnotation: Identifiable {
    let id = UUID()
    let fish: Fish
    
    var title: String { fish.title ?? "No title found"}
    var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: fish.lat, longitude: fish.long)}
    
    init(fish: Fish) {
        self.fish = fish
    }
}
