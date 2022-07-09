//
//  DefaultForecastCacheDataSource.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import CoreData
import Foundation

struct DefaultForecastCacheDataSource: ForecastCacheDataSource {
    let contaner: NSPersistentContainer
    
    func cached() async throws -> LocationForecasts? {
        let context = contaner.newBackgroundContext()
        let request = LocationForecastsMO.fetchRequest()
        request.fetchLimit = 1
        
        let result = try context.fetch(request)
        return result.first?.toLocationForecasts()
    }
    
    func cache(forecasts: LocationForecasts) async throws {
        let context = contaner.newBackgroundContext()
        
        let locationMO = LocationMO(context: context)
        locationMO.title = forecasts.location.title
        
        let forecasts = forecasts.forecasts.map { forecast -> ForecastMO in
            let forecastMO = ForecastMO(context: context)
            forecastMO.timestamp = forecast.timestamp
            forecastMO.title = forecast.title
            forecastMO.text = forecast.description
            forecastMO.condition = forecast.condition.rawValue
            forecastMO.temperature = forecast.temperature
            forecastMO.maxTemperature = forecast.maxTemperature
            forecastMO.minTemperature = forecast.minTemperature
            
            return forecastMO
        }
        
        let locationForecastsMO = LocationForecastsMO(context: context)
        locationForecastsMO.location = locationMO
        locationForecastsMO.forecasts = NSSet(array: forecasts)
        
        try context.save()
    }
    
    func clear() async throws {
        let context = contaner.newBackgroundContext()
        let request: NSFetchRequest<NSFetchRequestResult> = LocationForecastsMO.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        try context.execute(deleteRequest)
    }
}
