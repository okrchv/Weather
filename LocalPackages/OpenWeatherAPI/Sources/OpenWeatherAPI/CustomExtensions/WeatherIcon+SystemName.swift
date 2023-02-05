//
//  File.swift
//  
//
//  Created by Oleh Kiurchev on 04.02.2023.
//

import Foundation

extension Weather.Icon {
    public var systemName: String {
        switch self {
        case ._01d, ._01n:
            return "sun.max"
        case ._02d, ._02n:
            return "cloud.sun"
        case ._03d, ._03n:
            return "cloud"
        case ._04d, ._04n:
            return "smoke"
        case ._09d, ._09n:
            return "cloud.heavyrain"
        case ._10d, ._10n:
            return "cloud.rain"
        case ._11d, ._11n:
            return "cloud.bolt"
        case ._13d, ._13n:
            return "snowflake"
        case ._50d, ._50n:
            return "cloud.fog"
        }
    }
}
