//
//  Location.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import Foundation

struct Location: Identifiable {
    let id: UUID
    let title: String
}

extension Location: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

#if DEBUG

extension Location {
    static var mock: Location {
        Location(
            id: UUID(),
            title: "California"
        )
    }
}

#endif
