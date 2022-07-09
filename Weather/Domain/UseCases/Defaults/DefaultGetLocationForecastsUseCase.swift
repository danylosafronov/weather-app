//
//  DefaultGetLocationForecastsUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct DefaultGetLocationForecastsUseCase: GetLocationForecastsUseCase {
    let repository: ForecastRepository
    
    func invoke(for coordinates: Coordinates?) async throws -> LocationForecasts? {
        if let coordinates = coordinates {
            let locationForecasts = try await repository.fetch(for: coordinates)
            try await repository.cache(forecasts: locationForecasts)

            return locationForecasts
        }
        
        return try await repository.cached()
    }
}
