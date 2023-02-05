//
//  MKCoordinateRegion+Equatable.swift
//  Weather
//
//  Created by Oleh Kiurchev on 02.02.2023.
//

import Foundation
import MapKit

extension MKCoordinateRegion: Equatable {
    static public func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.center == rhs.center && lhs.span == lhs.span
    }
}
