//
//  DefaultResolveHourlyForecastUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct DefaultResolveHourlyLocationForecastsUseCase: ResolveHourlyLocationForecastsUseCase {
    func invoke(count: Int, from locationForecasts: LocationForecasts) -> LocationForecasts? {
        var count = count
        if locationForecasts.forecasts.count < count {
            count = locationForecasts.forecasts.count
        }
        
        let index = count - 1
        return LocationForecasts(
            id: UUID(),
            location: locationForecasts.location,
            forecasts: Array(locationForecasts.forecasts[...index])
        )
    }
}
