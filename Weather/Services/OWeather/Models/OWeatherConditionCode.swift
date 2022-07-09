//
//  OWeatherType.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

enum OWeatherCondition: CaseIterable {
    case thunderstorm
    case drizzle
    case rain
    case snow
    case atmosphere
    case clear
    case clouds
}

extension OWeatherCondition {
    var codes: Range<Int> {
        switch self {
        case .thunderstorm: return 200..<300
        case .drizzle: return 300..<400
        case .rain: return 500..<600
        case .snow: return 600..<700
        case .atmosphere: return 700..<800
        case .clear: return 800..<801
        case .clouds: return 801..<900
        }
    }
}
