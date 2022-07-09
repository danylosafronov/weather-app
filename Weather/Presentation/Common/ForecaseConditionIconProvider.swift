//
//  ForecaseConditionIconProvider.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation
import UIKit

struct ForecaseConditionIconProvider {
    static func make(by condition: ForecaseCondition?) -> UIImage? {
        guard let condition = condition else { return nil }

        switch condition {
        case .thunderstorm: return UIImage(systemName: "cloud.bolt.rain.fill")
        case .drizzle: return UIImage(systemName: "cloud.drizzle.fill")
        case .rain: return UIImage(systemName: "cloud.rain.fill")
        case .snow: return UIImage(systemName: "cloud.snow.fill")
        case .atmosphere: return UIImage(systemName: "sun.haze.fill")
        case .clear: return UIImage(systemName: "sun.min.fill")
        case .clouds: return UIImage(systemName: "cloud.fill")
        }
    }
}
