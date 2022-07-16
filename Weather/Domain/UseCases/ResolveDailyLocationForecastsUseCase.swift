//
//  ResolveDailyLocationForecastsUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

protocol ResolveDailyLocationForecastsUseCase {
    func invoke(count: Int, from locationForecasts: LocationForecasts, fromDate date: Date) -> LocationForecasts?
}
