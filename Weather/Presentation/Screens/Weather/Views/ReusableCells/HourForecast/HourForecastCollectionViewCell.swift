//
//  HourForecastCollectionViewCell.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import UIKit

final class HourForecastCollectionViewCell: WeatherCollectionViewCell<HourForecastView> {
    
    // MARK: - UICollectionReusableView lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(for: nil)
    }
    
    // MARK: - Actions
    
    func configure(for forecast: Forecast?) {
        let hour = Calendar.current.component(.hour, from: forecast?.timestamp ?? Date())
        let temperature = TemperatureProvider.format(for: forecast?.temperature, in: .celsius)
        let image = ForecaseConditionIconProvider.make(by: forecast?.condition)
        
        nestedView.configureHoutLabelText("\(hour)")
        nestedView.configureWeatherImageViewImage(image)
        nestedView.configureTemperatureLabel("\(temperature)")
    }
}
