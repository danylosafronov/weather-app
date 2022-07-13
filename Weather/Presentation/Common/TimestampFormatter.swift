//
//  TimestampFormatter.swift
//  Weather
//
//  Created by Danylo Safronov on 13.07.2022.
//

import Foundation

struct TimestampFormatter {
    enum Format {
        case hour
        case day
    }
    
    static func format(_ timestamp: Date, to format: Format) -> String {
        self.format(
            timestamp,
            to: resolveFormat(by: format)
        )
    }
    
    static func format(_ timestamp: Date, to format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: timestamp).capitalized
    }
    
    private static func resolveFormat(by format: Format) -> String {
        switch format {
        case .hour: return "HH"
        case .day: return "EEEEEE"
        }
    }
}
