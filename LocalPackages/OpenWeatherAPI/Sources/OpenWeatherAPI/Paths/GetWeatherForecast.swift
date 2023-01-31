// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import Get

extension Paths {
    /// Call weather data for one location
    ///
    /// Just one API call and get all your essential weather data for a specific location
    static public func getWeatherForecast(lat: String, lon: String) -> Request<OpenWeatherAPI.OnecallResponse> {
        Request(path: "/data/3.0/onecall", method: "GET", query: [("lat", lat), ("lon", lon)], id: "getWeatherForecast")
    }
}