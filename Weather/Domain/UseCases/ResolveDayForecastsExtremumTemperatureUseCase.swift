//
//  ResolveDayForecastsExtremumTemperatureUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 16.07.2022.
//

import Foundation

protocol ResolveDayForecastsExtremumTemperatureUseCase {
    func invoke(from forecasts: Forecasts, forDay date: Date) -> (Float?, Float?)
}
