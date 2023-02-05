//
//  CurrentForecastView.swift
//  Weather
//
//  Created by Oleh Kiurchev on 03.02.2023.
//

import SwiftUI
import CoreLocation
import OpenWeatherAPI


struct CurrentForecastView: View {
    var forecastData: ForecastData
    var locationCoordinate: CLLocationCoordinate2D
    var onLocationSearchToggle: () -> Void
    
    @State private var locationData: LocationData?
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                HStack {
                    HStack(spacing: 5) {
                        Image(systemName: "location.fill")
                        Text(locationData?.name ?? "--")
                            .kerning(0.5)
                            .lineLimit(1)
                    }
                        .font(.system(.title2))
                    Spacer()
                    Button(action: onLocationSearchToggle) {
                        Image(systemName: "location.magnifyingglass")
                            .font(Font.custom("Helvetica", size: 22))
                    }
                }
                HStack {
                    Text(dateFormatter(forecastData.dt))
                        .font(Font.custom("Helvetica", size: 13))
                    Spacer()
                }
            }
            Spacer(minLength: 50)
            HStack(spacing: 30) {
                if let iconName = forecastData.weather.first?.icon.systemName  {
                    Image(systemName: iconName)
                        .font(.system(size: 100))
                } else {
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "thermometer")
                            .frame(width: 20)
                        Text("\(Int(forecastData.temp.rounded()))°")
                    }
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "humidity.fill")
                            .frame(width: 20)
                        Text("\(forecastData.humidity)%")
                    }
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "wind")
                            .frame(width: 20)
                        HStack(spacing: 10) {
                            Text("\(Int(forecastData.windSpeed)) м/сек")
                            Image(systemName: forecastData.windDirection.systemName)
                        }
                    }
                }
                .font(Font.custom("Helvetica", size: 20))
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 40)
        .padding(.bottom, 40)
        .background(Color("DarkBlue"))
        .foregroundColor(Color("White"))
        .task(id: locationCoordinate) {
            if let locationData = await getLocationData(locationCoordinate) {
                self.locationData = locationData
            }
        }
    }
    
    func getLocationData(_ coordinate: CLLocationCoordinate2D) async -> LocationData? {
        let response = try? await OpenWeatherAPI.Client.shared?.send(
            OpenWeatherAPI.Paths.reverseGeocode(lat: coordinate.latitude, lon: coordinate.longitude)
        )
        
        return response?.value.first
    }
    
    func dateFormatter(_ dt: Int32) -> String {
        let date = Date(timeIntervalSince1970: Double(dt))
        let formattedDate = date.formatted(.dateTime.weekday(.short).day(.twoDigits).month(.wide))
        
        return formattedDate
    }
    

}

//struct CurrentForecastView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentForecastView()
//    }
//}
