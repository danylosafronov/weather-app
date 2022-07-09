//
//  OWeatherError.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

enum OWeatherError: Error {
    case malformedUrl
    case invalidUrl
    case badServerResponse
}
