//
//  MapView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 29.12.2022.
//

import SwiftUI
import MapKit
import CoreData

struct MapView: UIViewRepresentable {
    @Environment(\.managedObjectContext) var managedObjectContext

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let request: NSFetchRequest<Fish> = Fish.fetchRequest()
        do {
            let pins = try managedObjectContext.fetch(request)
            if(pins.isEmpty) {
                print("No pins")
            } else {
            for pin in pins {
                let annotation = MKPointAnnotation()
                annotation.title = pin.title
                annotation.coordinate = CLLocationCoordinate2D(latitude: pin.lat, longitude: pin.long)
                uiView.addAnnotation(annotation)
            }
            }
        } catch {
            print(error)
        }
    }
}
