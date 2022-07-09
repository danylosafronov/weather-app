//
//  OWeatherCity.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct OWeatherCity: Codable {
    let id: Int
    let name: String
    let coord: OWeatherCoordinates
}
