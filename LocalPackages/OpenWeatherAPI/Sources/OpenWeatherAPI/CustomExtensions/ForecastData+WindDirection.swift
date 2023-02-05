//
//  File.swift
//  
//
//  Created by Oleh Kiurchev on 04.02.2023.
//

import Foundation

extension ForecastData {
    public enum WindDirection {
        case n
        case ne
        case e
        case se
        case s
        case sw
        case w
        case nw
        
        public var systemName: String {
            switch self {
            case .n:
                return "arrow.up"
            case .ne:
                return "arrow.up.right"
            case .e:
                return "arrow.right"
            case .se:
                return "arrow.down.right"
            case .s:
                return "arrow.down"
            case .sw:
                return "arrow.down.left"
            case .w:
                return "arrow.left"
            case .nw:
                return "arrow.up.left"
            }
        }
    }

    public var windDirection: WindDirection {
        switch self.windDeg {
        case 338..<360,
             0..<23:
            return .n
        case 23..<68:
            return .ne
        case 68..<113:
            return .e
        case 113..<158:
            return .se
        case 158..<203:
            return .s
        case 203..<248:
            return .sw
        case 248..<293:
            return .w
        case 293..<338:
            return .nw
        default:
            return .n
        }
    }
}
