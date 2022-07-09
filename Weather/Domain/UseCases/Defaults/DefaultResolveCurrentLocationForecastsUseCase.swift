//
//  DefaultResolveCurrentLocationForecastsUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct DefaultResolveCurrentLocationForecastsUseCase: ResolveCurrentLocationForecastsUseCase {
    func invoke(from locationForecasts: LocationForecasts) -> LocationForecasts? {
        let forecast = locationForecasts.forecasts.min { $0.timestamp < $1.timestamp }
        guard let forecast = forecast else { return nil }
        
        return LocationForecasts(
            id: UUID(),
            location: locationForecasts.location,
            forecasts: [forecast]
        )
    }
}
