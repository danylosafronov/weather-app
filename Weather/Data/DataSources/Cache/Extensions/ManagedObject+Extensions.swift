//
//  ManagedObject+Extensions.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

extension LocationForecastsMO {
    func toLocationForecasts() -> LocationForecasts {
        LocationForecasts(
            id: UUID(),
            location: location!.toLocation(),
            forecasts: forecasts!.map { ($0 as! ForecastMO).toForecast() }
        )
    }
}

extension LocationMO {
    func toLocation() -> Location {
        Location(
            id: UUID(),
            title: title!
        )
    }
}

extension ForecastMO {
    func toForecast() -> Forecast {
        Forecast(
            id: UUID(),
            timestamp: timestamp!,
            title: title!,
            description: text!,
            condition: ForecaseCondition(rawValue: condition!)!,
            temperature: temperature,
            maxTemperature: maxTemperature,
            minTemperature: minTemperature
        )
    }
}
