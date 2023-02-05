//
//  DayForecastView.swift
//  Weather
//
//  Created by Oleh Kiurchev on 30.01.2023.
//

import SwiftUI
import OpenWeatherAPI

struct DayForecastView: View {
    var forecastData: [DailyForecastData]
    
    @State var selectedRow: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ForEach(forecastData, id: \.self) { forecast in
                HStack {
                    Text(dateFormatter(forecast.dt))
                        .font(Font.custom("Helvetica", size: 20))
                        .frame(width: 34)
                    Spacer()
                    Text("\(Int(forecast.temp.max.rounded()))° / \(Int(forecast.temp.min.rounded()))°")
                    Spacer()
                    if let iconName = forecast.weather.first?.icon.systemName  {
                        Image(systemName: iconName)
                            .frame(width: 34)
                    } else {
                        Spacer()
                    }
                }
                .font(Font.custom("Helvetica", size: 24))
                .padding(.vertical, 20)
                .foregroundColor(Color("Black"))
                .background(Color("White"))
                .contentShape(Rectangle())
            }
        }
        .padding(.horizontal, 20)
    }
    
    func dateFormatter(_ dt: Int32) -> String {
        let date = Date(timeIntervalSince1970: Double(dt))
        let formattedDate = date.formatted(.dateTime.weekday(.short)).uppercased()
        
        return formattedDate
    }
}

//struct DayForecastView_Previews: PreviewProvider {
//    static var previews: some View {
//        DayForecastView()
//    }
//}
