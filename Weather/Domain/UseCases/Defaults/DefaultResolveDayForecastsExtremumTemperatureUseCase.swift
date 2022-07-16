//
//  DefaultResolveDayForecastsExtremumTemperatureUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 16.07.2022.
//

import Foundation

struct DefaultResolveDayForecastsExtremumTemperatureUseCase: ResolveDayForecastsExtremumTemperatureUseCase {
    func invoke(from forecasts: Forecasts, forDay date: Date) -> (Float?, Float?) {
        var lowestTemperature: Float? = nil
        var highestTemperature: Float? = nil
        
        for forecast in forecasts {
            guard Calendar.current.isDate(forecast.timestamp, inSameDayAs: date) else { continue }
            
            if highestTemperature == nil || forecast.maxTemperature > highestTemperature! {
                highestTemperature = forecast.maxTemperature
            }
            
            if lowestTemperature == nil || forecast.minTemperature < lowestTemperature! {
                lowestTemperature = forecast.minTemperature
            }
        }
        
        return (lowestTemperature, highestTemperature)
    }
}
