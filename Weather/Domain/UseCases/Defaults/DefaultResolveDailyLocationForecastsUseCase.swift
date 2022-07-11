//
//  DefaultResolveDailyLocationForecastsUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct DefaultResolveDailyLocationForecastsUseCase: ResolveDailyLocationForecastsUseCase {
    func invoke(count: Int, from locationForecasts: LocationForecasts) -> LocationForecasts? {
        let sortedForecasts = locationForecasts.forecasts.sorted { $0.timestamp < $1.timestamp }
        var date = Date()
        var forecasts: [Forecast] = []
        
        for forecast in sortedForecasts {
            if forecast.timestamp > date {
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                forecasts += [forecast]
                
                guard forecasts.count < count else { break }
            }
        }
        
        return LocationForecasts(
            id: UUID(),
            location: locationForecasts.location,
            forecasts: forecasts
        )
    }
}
