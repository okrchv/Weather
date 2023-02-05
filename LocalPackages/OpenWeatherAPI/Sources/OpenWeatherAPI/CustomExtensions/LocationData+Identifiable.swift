//
//  LocationData+Identifiable.swift
//  
//
//  Created by Oleh Kiurchev on 02.02.2023.
//

import Foundation

extension LocationData: Identifiable {
    public var id: Int {
        self.hashValue
    }
}
