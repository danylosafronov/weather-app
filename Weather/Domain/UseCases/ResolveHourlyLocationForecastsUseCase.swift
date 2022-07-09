//
//  ResolveHourlyForecastUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

protocol ResolveHourlyLocationForecastsUseCase {
    func invoke(count: Int, from locationForecasts: LocationForecasts) -> LocationForecasts?
}
