//
//  ResolveLocationForecastUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

protocol ResolveCurrentLocationForecastsUseCase {
    func invoke(from locationForecasts: LocationForecasts) -> LocationForecasts?
}
