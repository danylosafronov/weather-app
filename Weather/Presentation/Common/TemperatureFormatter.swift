//
//  TemperatureFormatter.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import Foundation

struct TemperatureFormatter {
    static func format(for value: Float?, in unit: UnitTemperature) -> String {
        var symbol = unit.symbol
        if unit == .celsius {
           symbol = "°"
        }
        
        guard var value = value else { return "" }
        value = round(value * 10) / 10
        
        return "\(value)\(symbol)"
    }
}
