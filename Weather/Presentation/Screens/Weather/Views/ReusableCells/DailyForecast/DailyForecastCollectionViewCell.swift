//
//  DailyForecastCollectionView.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import UIKit

final class DailyForecastCollectionViewCell: WeatherCollectionViewCell<DailyForecastView> {
    
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
