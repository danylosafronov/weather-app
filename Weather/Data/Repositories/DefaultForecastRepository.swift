//
//  DefaultForecastRepository.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct DefaultForecastRepository: ForecastRepository {
    let networkDataSource: ForecastNetworkDataSource
    let cacheDataSource: ForecastCacheDataSource
    
    func fetch(for coordinates: Coordinates) async throws -> LocationForecasts {
        try await networkDataSource.fetch(for: coordinates)
    }
    
    func cached() async throws -> LocationForecasts? {
        try await cacheDataSource.cached()
    }
    
    func cache(forecasts: LocationForecasts) async throws {
        try await cacheDataSource.clear()
        try await cacheDataSource.cache(forecasts: forecasts)
    }
}
