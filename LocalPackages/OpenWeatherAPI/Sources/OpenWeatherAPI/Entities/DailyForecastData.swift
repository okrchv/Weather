// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct DailyForecastData: Codable, Hashable {
    /// Time of data calculation, unix, UTC
    public var dt: Int32
    public var temp: Temp
    /// (more info Weather condition codes)
    public var weather: [Weather]

    public struct Temp: Codable, Hashable {
        public var min: Double
        public var max: Double

        public init(min: Double, max: Double) {
            self.min = min
            self.max = max
        }

        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: StringCodingKey.self)
            self.min = try values.decode(Double.self, forKey: "min")
            self.max = try values.decode(Double.self, forKey: "max")
        }

        public func encode(to encoder: Encoder) throws {
            var values = encoder.container(keyedBy: StringCodingKey.self)
            try values.encode(min, forKey: "min")
            try values.encode(max, forKey: "max")
        }
    }

    public init(dt: Int32, temp: Temp, weather: [Weather]) {
        self.dt = dt
        self.temp = temp
        self.weather = weather
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: StringCodingKey.self)
        self.dt = try values.decode(Int32.self, forKey: "dt")
        self.temp = try values.decode(Temp.self, forKey: "temp")
        self.weather = try values.decode([Weather].self, forKey: "weather")
    }

    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: StringCodingKey.self)
        try values.encode(dt, forKey: "dt")
        try values.encode(temp, forKey: "temp")
        try values.encode(weather, forKey: "weather")
    }
}
