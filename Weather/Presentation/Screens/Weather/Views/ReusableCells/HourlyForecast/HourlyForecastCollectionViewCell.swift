//
//  HourlyForecastCollectionView.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import UIKit

final class HourlyForecastCollectionViewCell: WeatherCollectionViewCell<HourlyForecastView> {

    // MARK: - UICollectionReusableView lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        configure(for: nil)
    }
    
    // MARK: - Actions
    
    func configure(for forecasts: LocationForecasts?) {
        nestedView.apply(forecasts: forecasts)
    }
}
