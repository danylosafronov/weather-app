//
//  DefaultResolveHourlyForecastUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct DefaultResolveHourlyLocationForecastsUseCase: ResolveHourlyLocationForecastsUseCase {
    func invoke(count: Int, from locationForecasts: LocationForecasts) -> LocationForecasts? {
        let sortedForecasts = locationForecasts.forecasts.sorted { $0.timestamp < $1.timestamp }
        var count = count
        
        if sortedForecasts.count < count {
            count = locationForecasts.forecasts.count
        }
        
        let index = count - 1
        return LocationForecasts(
            id: UUID(),
            location: locationForecasts.location,
            forecasts: Array(sortedForecasts[...index])
        )
    }
}
