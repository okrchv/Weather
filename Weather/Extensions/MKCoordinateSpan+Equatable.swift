//
//  MKCoordinateSpan+Equatable.swift
//  Weather
//
//  Created by Oleh Kiurchev on 02.02.2023.
//

import Foundation
import MapKit

extension MKCoordinateSpan: Equatable {
    static public func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == lhs.longitudeDelta
    }
}
