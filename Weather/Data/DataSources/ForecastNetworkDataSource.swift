//
//  ForecastNetworkDataSource.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

protocol ForecastNetworkDataSource {
    func fetch(for coordinates: Coordinates) async throws -> LocationForecasts
}
