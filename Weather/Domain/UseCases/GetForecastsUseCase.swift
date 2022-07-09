//
//  GetForecastsUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

protocol GetForecastsUseCase {
    func invoke(for coordinates: Coordinates?) async throws -> (LocationForecasts?, LocationForecasts?, LocationForecasts?)
}
