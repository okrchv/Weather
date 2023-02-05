//
//  CLLocationCoordinate2D+Equatable.swift
//  Weather
//
//  Created by Oleh Kiurchev on 02.02.2023.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    static public func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
