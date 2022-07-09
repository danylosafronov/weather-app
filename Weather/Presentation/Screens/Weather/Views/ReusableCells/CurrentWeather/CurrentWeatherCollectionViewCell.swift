//
//  CurrentWeatherCollectionView.swift
//  Weather
//
//  Created by Danylo Safronov on 07.07.2022.
//

import Foundation
import UIKit

final class CurrentWeatherCollectionViewCell: WeatherCollectionViewCell<CurrentWeatherView> {
    
    // MARK: - UICollectionReusableView lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(for: nil)
    }
    
    // MARK: - Actions
    
    func configure(for locationForecasts: LocationForecasts?) {
        let temperature = TemperatureProvider.format(for: locationForecasts?.forecasts.first?.temperature, in: .celsius)
        let highestTemperature = TemperatureProvider.format(for: locationForecasts?.forecasts.first?.maxTemperature, in: .celsius)
        let lowestTemperature = TemperatureProvider.format(for: locationForecasts?.forecasts.first?.minTemperature, in: .celsius)
        
        nestedView.configureCurrentLocationLabelText(locationForecasts?.location.title)
        nestedView.configureCurrentWeatherLabelText(locationForecasts?.forecasts.first?.title)
        nestedView.configureCurrentTemperatureLabelText("\(temperature)")
        nestedView.configureHighestTemperatureLabel("H: \(highestTemperature)")
        nestedView.configureLowestTemperatureLabel("L: \(lowestTemperature)")
    }
}
