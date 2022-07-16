//
//  LocationForecasts.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct LocationForecasts: Identifiable {
    let id: UUID
    let location: Location
    let forecasts: Forecasts
}

extension LocationForecasts: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

#if DEBUG

extension LocationForecasts {
    static var mock: LocationForecasts {
        LocationForecasts(
            id: UUID(),
            location: .mock,
            forecasts: [
                .mock,
                .mock,
                .mock,
                .mock,
                .mock,
                .mock
            ]
        )
    }
}

#endif
