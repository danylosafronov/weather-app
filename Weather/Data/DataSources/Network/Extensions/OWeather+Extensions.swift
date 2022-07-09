//
//  OWeatherForecasts+Extensions.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

extension OWeatherForecasts {
    func toLocationForecasts() -> LocationForecasts {
        LocationForecasts(
            id: UUID(),
            location: city.toLocation(),
            forecasts: list.map { forecast in
                forecast.toForecast()
            }
        )
    }
}

extension OWeatherCity {
    func toLocation() -> Location {
        Location(
            id: UUID(),
            title: name
        )
    }
}

extension OWeatherForecast {
    func toForecast() -> Forecast {
        Forecast(
            id: UUID(),
            timestamp: Date(timeIntervalSince1970: dt),
            title: weather.first?.main ?? "",
            description: weather.first?.description ?? "",
            condition: resolveCondition(by: weather.first?.id ?? .zero),
            temperature: main.temp,
            maxTemperature: main.tempMax,
            minTemperature: main.tempMin
        )
    }
    
    private func resolveCondition(by id: Int) -> ForecaseCondition {
        for condition in OWeatherCondition.allCases {
            if condition.codes.contains(id) {
                return resolveCondition(by: condition)
            }
        }
        
        return .clear
    }
    
    private func resolveCondition(by condition: OWeatherCondition) -> ForecaseCondition {
        switch condition {
        case .thunderstorm: return .thunderstorm
        case .drizzle: return .drizzle
        case .rain: return .rain
        case .snow: return .snow
        case .atmosphere: return .atmosphere
        case .clear: return .clear
        case .clouds: return .clouds
        }
    }
}
