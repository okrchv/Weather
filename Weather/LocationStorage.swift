//
//  LocationStorage.swift
//  Weather
//
//  Created by Oleh Kiurchev on 04.02.2023.
//

import Foundation
import CoreLocation

let userDefaultsKey = "locationCoordinate"

class LocationStorage: ObservableObject {
    @Published var coordinate: CLLocationCoordinate2D
    @Published var persisted = false

    init(_ initCoordinate: CLLocationCoordinate2D) {
        self.coordinate = initCoordinate

        let coordinateData = UserDefaults.standard.object(forKey: userDefaultsKey) as? Data

        if let coordinateData = coordinateData,
           let coordinate = dataToCoordinate(coordinateData) {
            print("LocationStorage retrieved coords", coordinate)
            
            self.persisted = true
            self.coordinate = coordinate
        } else {
            print("LocationStorage failed retrieving coords")

            self.persisted = false
            UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        }
    }

    func store(_ coordinate: CLLocationCoordinate2D) {
        print("LocationStorage saving coords")

        if let coordinateData = coordinateToData(coordinate) {
            self.persisted = true
            self.coordinate = coordinate
            UserDefaults.standard.set(coordinateData, forKey: userDefaultsKey)
            
            print("LocationStorage saved coords", coordinate)
        }
    }

    /// @see https://stackoverflow.com/questions/30828964/convert-nsvalue-to-nsdata-and-back-again-with-the-correct-type
    /// @see https://teamtreehouse.com/community/how-to-store-an-array-of-type-cllocationcoordinate2d-in-nsuserdefaults-in-swift-20
    private func coordinateToData(_ coordinate: CLLocationCoordinate2D) -> Data? {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return try? NSKeyedArchiver.archivedData(withRootObject: location, requiringSecureCoding: false)
    }
    
    private func dataToCoordinate(_ data: Data) -> CLLocationCoordinate2D? {
        let location = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? CLLocation
        return location?.coordinate
    }
}
