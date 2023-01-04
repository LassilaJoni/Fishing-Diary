import SwiftUI
import MapKit
import CoreData
import CoreLocationUI
import StoreKit


struct MapMainView: View {
    
    
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var locationManager = LocationManager.shared
    static let shared = LocationManager()
    @State private var region = MKCoordinateRegion(center: LocationManager.currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
    
    @State private var selectedFish: Fish?
    
    
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                annotationItems: annotations) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    FishAnnotationView(title: annotation.title)
                        .scaleEffect(selectedFish == annotation.fish ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            selectedFish = annotation.fish
                        }
                }
            }
            .onAppear(perform: updateMapView)
            .ignoresSafeArea()
            VStack {
            // Add the label on top of the map view
            if(MapMainView.shared.locationManager.location == nil) {
                Text("Location not available")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(20)
                Text("You can turn location on by pressing the Current Location button below or by changing location access in settings of the phone.")
                    .font(.subheadline)
            }
            Spacer()
                // Place the LocationButton at the bottom of the screen
                if(selectedFish == nil) {
                LocationButton {
                    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    let region = MKCoordinateRegion(center: LocationManager.currentLocation, span: span)
                    self.region = region
                }
                .frame(width: 180, height: 40)
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
                .padding(.bottom, 10)
                }
                

                if let selectedFish = selectedFish {
                    VStack {
                        withAnimation(.easeInOut(duration: 4)) {
                            LocationPreviewView(fish: selectedFish)
                                .shadow(color: Color.black.opacity(0.3), radius: 20)
                                .padding()
    
                                .onTapGesture {
                                    self.selectedFish = nil
                                }
                        }
                    }
                }
            }
        }
    }
    var annotations: [FishAnnotation] {
        let fish = fetchFish()
        return fish.map { FishAnnotation(fish: $0) }
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
    
    private func updateMapView() {
            locationManager.requestLocation()
        region = MKCoordinateRegion(center: LocationManager.currentLocation, span: LocationManager.currentLocationSpan)
        }
    
    }
 
struct MapMainView_Previews: PreviewProvider {
    
    @State static var mapView: MKMapView = MKMapView()
    
    static var previews: some View {
        MapMainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

