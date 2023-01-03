////
////  MapMainView.swift
////  Fishing-Diary
////
////  Created by Joni Lassila on 29.12.2022.
////
//
//import SwiftUI
//import MapKit
//import CoreData
//import CoreLocationUI
//import StoreKit
//
//
//struct MapMainView: View {
//
//    struct FishAnnotation: Identifiable {
//        let id = UUID()
//        let name: String
//        let coordinate: CLLocationCoordinate2D
//    }
//
//        @Environment(\.managedObjectContext) private var moc
//        @ObservedObject var locationManager = LocationManager.shared
//
//        @State private var region = MKCoordinateRegion(center: LocationManager.currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//    let mapView = MKMapView()
//        @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//
//        NavigationView {
//
//           //MapView()
//            Map(coordinateRegion: $region,
//                            interactionModes: .all,
//                            showsUserLocation: true,
//                            annotationItems: annotations) {
//                            MapPin(coordinate: $0.coordinate)
//            }
//               // .ignoresSafeArea(.all)
//                .toolbar {
//                    ToolbarItemGroup(placement: .navigationBarLeading) {
//                        Button(action: dismiss, label: {
//                            Circle()
//                                .fill(Color(.black))
//                                .frame(width: 40, height: 30) // You can make this whatever size, but keep UX in mind.
//                                .overlay(
//                                    Image(systemName: "xmark")
//                                        .font(.system(size: 15, weight: .bold, design: .rounded)) // This should be less than the frame of the circle
//                                        .foregroundColor(.white)
//                                )
//                        })
//                        .buttonStyle(PlainButtonStyle())
//                        .accessibilityLabel(Text("Close"))
//                    }
//                }
//
//        }
//
//
//    }
//
//    private mutating func updateMapView(_ uiView: MKMapView) {
////        guard moc.persistentStoreCoordinator != nil else {
////            print("erroria pukkaa")
////            return
////        }
//
//        let request: NSFetchRequest<Fish> = Fish.fetchRequest()
//        do {
//            let pins = try moc.fetch(request)
//            // create the annotations array using the fishes array
////            self.annotations = pins.map { pin in
//            for pin in pins {
//                let annotation = MKPointAnnotation()
//                annotation.title = pin.title
//                                annotation.coordinate = CLLocationCoordinate2D(latitude: pin.lat, longitude: pin.long)
//                                uiView.addAnnotation(annotation)
////                FishAnnotation(name: pin.title ?? "No data found", coordinate: CLLocationCoordinate2D(latitude: pin.lat, longitude: pin.long))
//            }
//        } catch {
//            print("Error fetching fish entities: \(error)")
//        }
//    }
////    func updateUIView(_ uiView: MKMapView, context: Context) {
////        let request: NSFetchRequest<Fish> = Fish.fetchRequest()
////        do {
////            let pins = try managedObjectContext.fetch(request)
////            if(pins.isEmpty) {
////                print("No pins")
////            } else {
////            for pin in pins {
////                let annotation = MKPointAnnotation()
////                annotation.title = pin.title
////                annotation.coordinate = CLLocationCoordinate2D(latitude: pin.lat, longitude: pin.long)
////                uiView.addAnnotation(annotation)
////            }
////            }
////        } catch {
////            print(error)
////        }
////    }
//
//    private func dismiss() {
//        presentationMode.wrappedValue.dismiss()
//    }
//}
//struct MapMainView_Previews: PreviewProvider {
//
//    @State static var mapView: MKMapView = MKMapView()
//
//    static var previews: some View {
////        let context = PersistenceController.preview.container.viewContext
////        let fish = context.firstFish
//        MapMainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
//

//
//  MapMainView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 29.12.2022.
//

import SwiftUI
import MapKit
import CoreData
import CoreLocationUI
import StoreKit


struct MapMainView: View {
    
    struct FishAnnotation: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }
    
        @Environment(\.managedObjectContext) private var moc
        @ObservedObject var locationManager = LocationManager.shared
        
        @State private var region = MKCoordinateRegion(center: LocationManager.currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    let mapView = MKMapView()
        @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView {
            Map(coordinateRegion: $region,
                            interactionModes: .all,
                            showsUserLocation: true,
                            annotationItems: annotations) {
                            MapPin(coordinate: $0.coordinate)
            }
               // .ignoresSafeArea(.all)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: dismiss, label: {
                            Circle()
                                .fill(Color(.black))
                                .frame(width: 40, height: 30) // You can make this whatever size, but keep UX in mind.
                                .overlay(
                                    Image(systemName: "xmark")
                                        .font(.system(size: 15, weight: .bold, design: .rounded)) // This should be less than the frame of the circle
                                        .foregroundColor(.white)
                                )
                        })
                        .buttonStyle(PlainButtonStyle())
                        .accessibilityLabel(Text("Close"))
                    }
                }

        }
       
   
    }
    var annotations: [FishAnnotation] {
        let fish = fetchFish()
        return fish.map { FishAnnotation(name: $0.title ?? "No data found", coordinate: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.long)) }
    }
    
    func fetchFish() -> [Fish] {
        let request: NSFetchRequest<Fish> = Fish.fetchRequest()
        do {
            return try moc.fetch(request)
        } catch {
            print("Error fetching fish entities: \(error)")
            return []
        }
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
struct MapMainView_Previews: PreviewProvider {
    
    @State static var mapView: MKMapView = MKMapView()
    
    static var previews: some View {
//        let context = PersistenceController.preview.container.viewContext
//        let fish = context.firstFish
        MapMainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


