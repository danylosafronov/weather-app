//
//  OWeatherForecast.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct OWeatherForecasts: Codable {
    let list: [OWeatherForecast]
    let city: OWeatherCity
}
