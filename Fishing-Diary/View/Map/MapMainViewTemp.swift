import SwiftUI
import MapKit
import CoreData
import CoreLocationUI
import StoreKit


struct MapMainViewTemp: View {
    @State private var selectedFish: Fish?
    
        @Environment(\.managedObjectContext) private var moc
        @ObservedObject var locationManager = LocationManager.shared
        
        @State private var region = MKCoordinateRegion(center: LocationManager.currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        @Environment(\.presentationMode) var presentationMode
    
    let mapView = MKMapView()
    
    
    var body: some View {
        
        ZStack {
            MapView()
        }
   
}
}
struct MapMainViewTesti_Previews: PreviewProvider {
    
    @State static var mapView: MKMapView = MKMapView()
    
    static var previews: some View {
//        let context = PersistenceController.preview.container.viewContext
//        let fish = context.firstFish
        MapMainViewTemp().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}




