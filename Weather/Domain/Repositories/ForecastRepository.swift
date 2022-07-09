//
//  ForecastRepository.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

protocol ForecastRepository {
    func fetch(for coordinates: Coordinates) async throws -> LocationForecasts
    func cached() async throws -> LocationForecasts?
    func cache(forecasts: LocationForecasts) async throws
}
