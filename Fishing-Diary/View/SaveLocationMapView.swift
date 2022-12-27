//
//  SaveLocationMapView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 27.12.2022.
//

import SwiftUI
import MapKit

struct SaveLocationMapView: View {
    
    @State public var region: MKCoordinateRegion = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.4377599)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70.0, longitudeDelta: 70.0)
        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
        
        return mapRegion
    }()
    
    func getCoordinates() -> (Double, Double) {
        return (region.center.longitude, region.center.latitude)
    }
    
    var body: some View {
       Map(coordinateRegion: $region, showsUserLocation: true)
        Text("Long: \(region.center.longitude) Lat: \(region.center.latitude)")
            
    }
   
}



final class SaveLocationMapViewModel:NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
        } else {
            print("Location not enabled")
        }
    }
    
    
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else {return}

        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //Alert to user it's restricted, maybe becayse of parental controls
            print("Restricted.")
        case .denied:
            //Alert that user needs to go into settings to change it
            print("Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}





