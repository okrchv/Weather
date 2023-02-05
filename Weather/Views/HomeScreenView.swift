//
//  HomeScreenView.swift
//  Weather
//
//  Created by Oleh Kiurchev on 30.01.2023.
//

import SwiftUI
import CoreLocation
import OpenWeatherAPI

struct HomeScreenView: View {
    @EnvironmentObject var locationStorage: LocationStorage

    @State private var locationForecast: LocationForecast?
    @State private var showSearchLocationView = false
    
    var body: some View {
        VStack(spacing: 0) {
            if let locationForecast = locationForecast {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        CurrentForecastView(
                            forecastData: locationForecast.current,
                            locationCoordinate: locationStorage.coordinate
                        ) {
                            showSearchLocationView.toggle()
                        }
                        HourForecastView(forecastData: Array(locationForecast.hourly.prefix(24)))
                        DayForecastView(forecastData: locationForecast.daily)
                    }
                }
            } else {
                LaunchScreenView()
            }
        }
        .task(id: locationStorage.coordinate) {
            if let forecastData = await getForecast(locationStorage.coordinate) {
                self.locationForecast = forecastData
            }
        }
        .fullScreenCover(isPresented: $showSearchLocationView) {
            SearchLocationView()
        }
    }
    
    func getForecast(_ coordinate: CLLocationCoordinate2D) async -> LocationForecast? {
        let response = try? await OpenWeatherAPI.Client.shared?.send(
            OpenWeatherAPI.Paths.getWeatherForecast(parameters:
                .init(lat: coordinate.latitude, lon: coordinate.longitude, units: .metric)
            )
        )

        return response?.value
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
