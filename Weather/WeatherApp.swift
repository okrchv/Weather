//
//  WeatherApp.swift
//  Weather
//
//  Created by Oleh Kiurchev on 29.01.2023.
//

import SwiftUI
import CoreLocation
import OpenWeatherAPI

let initLocationCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)

@main
struct WeatherApp: App {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var locationStorage = LocationStorage(initLocationCoordinate)

    var body: some Scene {
        let _ = OpenWeatherAPI.Client.setSharedApiKey("d61850b53d3fa9a5aa8f2af505feca39")
        
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(locationStorage)
        }
    }
}
