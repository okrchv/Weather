//
//  HourForecastView.swift
//  Weather
//
//  Created by Oleh Kiurchev on 30.01.2023.
//

import SwiftUI
import OpenWeatherAPI

struct HourForecastView: View {
    var forecastData: [ForecastData]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 50) {
                ForEach(forecastData, id: \.self) { forecast in
                    VStack {
                        HStack(alignment: .top, spacing: 0) {
                            Text(dateFormatter(forecast.dt))
                                .font(Font.custom("Helvetica", size: 18))
                                .kerning(0.5)
                            
                            Text("00")
                                .font(Font.custom("Helvetica", size: 12))
                                .offset(x: 0, y: 1.5)
                        }
                        
                        Spacer(minLength: 20)
                        
                        VStack(spacing: 5) {
                            if let iconName = forecast.weather.first?.icon.systemName {
                                Image(systemName: iconName)
                            } else {
                                Spacer()
                            }
                            Text("\(Int(forecast.temp.rounded()))°")
                        }
                        .font(Font.custom("Helvetica Neue", size: 20))
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 28)
        .background(Color("LightBlue"))
        .foregroundColor(Color("White"))
    }
    
    func dateFormatter(_ dt: Int32) -> String {
        let date = Date(timeIntervalSince1970: Double(dt))
        let formattedDate = date.formatted(.dateTime.hour(.defaultDigits(amPM: .omitted)))
        
        return formattedDate
    }
}

//struct HourForecastView_Previews: PreviewProvider {
//    static var previews: some View {
//        HourForecastView()
//            .frame(height: 145)
//    }
//}
