//
//  Forecast.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import Foundation

struct Forecast: Identifiable {
    let id: UUID
    let timestamp: Date
    let title: String
    let description: String
    let condition: ForecaseCondition
    let temperature: Float
    let maxTemperature: Float
    let minTemperature: Float
}

extension Forecast: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

#if DEBUG

extension Forecast {
    static var mock: Forecast {
        Forecast(
            id: UUID(),
            timestamp: Date(),
            title: "Mock Title",
            description: "Mock Forecast",
            condition: .thunderstorm,
            temperature: 36.6,
            maxTemperature: 40.0,
            minTemperature: 0.0
        )
    }
}

#endif
