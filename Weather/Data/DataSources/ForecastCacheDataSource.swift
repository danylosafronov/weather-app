//
//  ForecastNetworkDataSource.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

protocol ForecastCacheDataSource {
    func cached() async throws -> LocationForecasts?
    func cache(forecasts: LocationForecasts) async throws
    func clear() async throws
}
