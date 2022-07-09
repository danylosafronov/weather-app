//
//  DefaultNetworkDataSource.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct DefaultForecastNetworkDataSource: ForecastNetworkDataSource {
    let oweather: OWeather
    
    func fetch(for coordinates: Coordinates) async throws -> LocationForecasts {
        let response = try await oweather.fetch(
            for: .init(
                lat: coordinates.latitude,
                lon: coordinates.longitude
            ),
            in: .metric
        )
        
        return response.toLocationForecasts()
    }
}
