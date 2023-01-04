import SwiftUI
import MapKit
import CoreData
import CoreLocationUI
import StoreKit


struct MapMainView: View {
    
    
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var locationManager = LocationManager.shared
    
    @State private var region = MKCoordinateRegion(center: LocationManager.currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @State private var selectedFish: Fish?
    
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
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
            Spacer()
            if let selectedFish = selectedFish {
                VStack {
                    withAnimation(.easeInOut(duration: 4)) {
                    LocationPreviewView(fish: selectedFish)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.moveAndFade)
                        .onTapGesture {
                            self.selectedFish = nil
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
        region = MKCoordinateRegion(center: LocationManager.currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
    
    }
 
struct MapMainView_Previews: PreviewProvider {
    
    @State static var mapView: MKMapView = MKMapView()
    
    static var previews: some View {
        MapMainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}
