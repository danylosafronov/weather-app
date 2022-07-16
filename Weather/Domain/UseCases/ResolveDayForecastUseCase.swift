//
//  ResolveDayForecastUseCase.swift
//  Weather
//
//  Created by Danylo Safronov on 16.07.2022.
//

import Foundation

protocol ResolveDayForecastUseCase {
    func invoke(from forecasts: Forecasts, forDay date: Date) -> Forecast?
}
