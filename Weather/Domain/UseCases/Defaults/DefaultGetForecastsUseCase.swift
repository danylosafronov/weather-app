//
//  DefaultGetForecastsUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct DefaultGetForecastsUseCase: GetForecastsUseCase {
    let getLocationForecasts: GetLocationForecastsUseCase
    let resolveCurrentLocationForecastsUseCase: ResolveCurrentLocationForecastsUseCase
    let resolveHourlyLocationForecastsUseCase: ResolveHourlyLocationForecastsUseCase
    let resolveDailyLocationForecastsUseCase: ResolveDailyLocationForecastsUseCase
    
    func invoke(for coordinates: Coordinates?) async throws -> (LocationForecasts?, LocationForecasts?, LocationForecasts?) {
        guard let forecasts = try await getLocationForecasts.invoke(for: coordinates) else {
            return (nil, nil, nil)
        }
        
        let currentForecasts = resolveCurrentLocationForecastsUseCase.invoke(from: forecasts)
        let hourlyLocationForecasts = resolveHourlyLocationForecastsUseCase.invoke(count: 8, from: forecasts)
        let dailyLocationForecasts = resolveDailyLocationForecastsUseCase.invoke(count: 5, from: forecasts)
        
        return (currentForecasts, hourlyLocationForecasts, dailyLocationForecasts)
    }
}
