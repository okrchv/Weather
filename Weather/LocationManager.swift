//
//  LocationManager.swift
//  Weather
//
//  Created by Oleh Kiurchev on 02.02.2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var locationAccess: LocationAccessStatus = .notDetermined
    @Published var location: CLLocation?
    

    override init() {
        super.init()
        manager.delegate = self
        
        print("Location manager init")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Location not determined")
            locationAccess = .notDetermined
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location access authorized")
            locationAccess = .allowed
            manager.requestLocation()
        case .denied, .restricted: fallthrough
        @unknown default:
            locationAccess = .denied
            print("Location access denied or restricted")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location retrieving fail error:", error.localizedDescription)
    }
}

enum LocationAccessStatus {
    case notDetermined
    case allowed
    case denied
}
