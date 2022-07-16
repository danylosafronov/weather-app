//
//  DefaultResolveDayForecastUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 16.07.2022.
//

import Foundation

struct DefaultResolveDayForecastUseCase: ResolveDayForecastUseCase {
    func invoke(from forecasts: Forecasts, forDay date: Date) -> Forecast? {
        var dateForecast: Forecast? = nil
        var lowestTemperature: Float? = nil
        var highestTemperature: Float? = nil
        
        for forecast in forecasts {
            guard Calendar.current.isDate(forecast.timestamp, inSameDayAs: date) else {
                continue
            }
                        
            if dateForecast == nil || dateForecast!.timestamp > forecast.timestamp {
                dateForecast = forecast
            }
            
            if highestTemperature == nil || forecast.maxTemperature > highestTemperature! {
                highestTemperature = forecast.maxTemperature
            }
            
            if lowestTemperature == nil || forecast.minTemperature < lowestTemperature! {
                lowestTemperature = forecast.minTemperature
            }
        }
        
        guard
            let dateForecast = dateForecast,
            let lowestTemperature = lowestTemperature,
            let highestTemperature = highestTemperature
        else {
            return nil
        }
        
        return Forecast(
            id: UUID(),
            timestamp: dateForecast.timestamp,
            title: dateForecast.title,
            description: dateForecast.description,
            condition: dateForecast.condition,
            temperature: dateForecast.temperature,
            maxTemperature: highestTemperature,
            minTemperature: lowestTemperature
        )
    }
}
