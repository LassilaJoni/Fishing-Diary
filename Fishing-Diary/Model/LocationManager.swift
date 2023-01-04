//
//  LocationManager.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 28.12.2022.
//

import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject {

    static let shared = LocationManager()
    static let DefaultLocation = CLLocationCoordinate2D(latitude: 51.505711, longitude: -0.079165)
    static let DefaultSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    static let DefaultSpanIfLocationKnown = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    static var currentLocation: CLLocationCoordinate2D {
        guard let location = shared.locationManager.location else {
            return DefaultLocation
        }
        return location.coordinate
    }
    
    static var currentLocationSpan: MKCoordinateSpan {
        if shared.locationManager.location != nil {
                    return DefaultSpanIfLocationKnown
                } else {
                    return DefaultSpan
                }
    }

     var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { }
    
    func requestLocation() {
            locationManager.requestLocation()
        }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location manager changed the status: \(status)")
    }
}
