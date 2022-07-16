//
//  DefaultResolveDailyLocationForecastsUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct DefaultResolveDailyLocationForecastsUseCase: ResolveDailyLocationForecastsUseCase {
    let resolveDayForecastUseCase: ResolveDayForecastUseCase
    
    func invoke(count: Int, from locationForecasts: LocationForecasts, fromDate date: Date) -> LocationForecasts? {
        var forecasts: Forecasts = []
        for date in makeDates(count: count, fromDate: date) {
            let dateForecasts = locationForecasts.forecasts.filter { Calendar.current.isDate($0.timestamp, inSameDayAs: date) }
            if let forecast = resolveDayForecastUseCase.invoke(from: dateForecasts, forDay: date) {
                forecasts += [forecast]
            }
        }
        
        return LocationForecasts(
            id: UUID(),
            location: locationForecasts.location,
            forecasts: forecasts
        )
    }
    
    private func makeDates(count: Int, fromDate date: Date) -> [Date] {
        var dates: [Date] = []
        for index in 1...count {
            guard let date = Calendar.current.date(byAdding: .day, value: index, to: date) else { break }
            dates += [date]
        }
        
        return dates
    }
}
