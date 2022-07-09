//
//  WeatherSectionBackroundReusableView.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import UIKit

final class WeatherSectionBackroundReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configure() {
        backgroundColor = UIColor(named: "cardBackgroundColor")
        layer.cornerRadius = 10.0
    }
}
