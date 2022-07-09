//
//  HourForecastCollectionViewCell.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import UIKit

final class DayForecastCollectionViewCell: WeatherCollectionViewCell<DayForecastView> {
    
    // MARK: - UICollectionReusableView lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(forecast: nil)
    }
    
    // MARK: - Actions
    
    func configure(forecast: Forecast?) {
        let day = resolveDay(of: forecast?.timestamp ?? Date())
        let temperature = TemperatureProvider.format(for: forecast?.temperature, in: .celsius)
        let highestTemperature = TemperatureProvider.format(for: forecast?.maxTemperature, in: .celsius)
        let lowestTemperature = TemperatureProvider.format(for: forecast?.minTemperature, in: .celsius)
        let image = ForecaseConditionIconProvider.make(by: forecast?.condition)
        
        nestedView.configureHoutLabelText("\(day)")
        nestedView.configureWeatherImageViewImage(image)
        nestedView.configureTemperatureLabel("\(temperature)")
        nestedView.configureHighestTemperatureLabelText("H: \(highestTemperature)")
        nestedView.configureLowestTemperatureLabelText("L: \(lowestTemperature)")
    }
    
    // MARK: - Logic
    
    private func resolveDay(of date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        
        return dateFormatter.string(from: date).capitalized
    }
}
