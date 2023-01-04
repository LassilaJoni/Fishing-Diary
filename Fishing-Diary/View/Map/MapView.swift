import SwiftUI
import MapKit
import CoreData
import CoreLocation


struct MapView: UIViewRepresentable {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var presentationMode: PresentationMode?
    var window: UIWindow?
    
    func makeUIView(context: Context) -> MKMapView {
            let mapView = MKMapView()
            mapView.showsUserLocation = true
            
            // Request permission to access the user's location
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            
            // Disable user tracking mode
            mapView.userTrackingMode = .none
            
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
