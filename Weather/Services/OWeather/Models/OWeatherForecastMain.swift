//
//  OWeatherForecastMain.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct OWeatherForecastMain: Codable {
    let temp: Float
    let tempMin: Float
    let tempMax: Float
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
