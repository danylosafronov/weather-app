//
//  DefaultResolveCurrentLocationForecastsUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct DefaultResolveCurrentLocationForecastsUseCase: ResolveCurrentLocationForecastsUseCase {
    let resolveDayForecastUseCase: ResolveDayForecastUseCase
    
    func invoke(from locationForecasts: LocationForecasts, forDay date: Date) -> LocationForecasts? {
        guard let dayForecast = resolveDayForecastUseCase.invoke(from: locationForecasts.forecasts, forDay: date) else {
            return nil
        }
        
        return LocationForecasts(
            id: UUID(),
            location: locationForecasts.location,
            forecasts: [dayForecast]
        )
    }
}
