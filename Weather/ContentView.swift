//
//  ContentView.swift
//  Weather
//
//  Created by Oleh Kiurchev on 29.01.2023.
//

import SwiftUI
import OpenWeatherAPI

struct ContentView: View {
    @EnvironmentObject private var locationStorage: LocationStorage
    @EnvironmentObject private var locationManager: LocationManager

    var body: some View {
        VStack(spacing: 0) {
            if locationStorage.persisted {
                HomeScreenView()
            } else {
                if locationManager.locationAccess == .denied {
                    ManualLocationPickerView()
                } else {
                    LaunchScreenView()
                }
            }
            
        }
        .ignoresSafeArea()
        .onChange(of: locationManager.location) { location in
            if let coordinate = location?.coordinate,
               locationStorage.persisted == false {
                locationStorage.store(coordinate)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
