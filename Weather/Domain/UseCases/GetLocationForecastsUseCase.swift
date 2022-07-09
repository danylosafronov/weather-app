//
//  GetLocationForecastsUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

protocol GetLocationForecastsUseCase {
    func invoke(for coordinates: Coordinates?) async throws -> LocationForecasts?
}
