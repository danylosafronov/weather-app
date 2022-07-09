//
//  OWeatherForecast.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct OWeatherForecast: Codable {
    let dt: Double
    let main: OWeatherForecastMain
    let weather: [OWeatherForecastWeather]
}
