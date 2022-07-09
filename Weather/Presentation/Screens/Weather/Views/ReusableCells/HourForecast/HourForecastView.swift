//
//  HourForecastView.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import UIKit

final class HourForecastView: UIView {
    private lazy var hourLabel = UILabel()
    private lazy var weatherImageView = UIImageView()
    private lazy var temperatureLabel = UILabel()
    private lazy var contentStackView = UIStackView()
    private lazy var contentLayoutGuide = UILayoutGuide()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configure() {
        configureContentLayoutGuide()
        configureContentStackView()
        configureHourLabel()
        configureWeatherImageView()
        configureTemperatureLabel()
    }
    
    private func configureContentLayoutGuide() {
        addLayoutGuide(contentLayoutGuide)
        
        NSLayoutConstraint.activate([
            contentLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
            contentLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func configureContentStackView() {
        addSubview(contentStackView)
        
        contentStackView.spacing = 8.0
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillProportionally
        contentStackView.alignment = .center
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: contentLayoutGuide.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: contentLayoutGuide.centerYAnchor),
        ])
    }
    
    private func configureHourLabel() {
        contentStackView.addArrangedSubview(hourLabel)
        
        hourLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        hourLabel.numberOfLines = 1
        hourLabel.textColor = UIColor(named: "textColor")
    }
    
    private func configureWeatherImageView() {
        contentStackView.addArrangedSubview(weatherImageView)
        
        weatherImageView.clipsToBounds = true
        weatherImageView.contentMode = .scaleAspectFill
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherImageView.widthAnchor.constraint(equalTo: contentLayoutGuide.widthAnchor, multiplier: 0.5),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor),
        ])
    }
    
    private func configureTemperatureLabel() {
        contentStackView.addArrangedSubview(temperatureLabel)
        
        temperatureLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        temperatureLabel.numberOfLines = 1
        temperatureLabel.textColor = UIColor(named: "textColor")
    }
    
    // MARK: - Actions
    
    func configureHoutLabelText(_ text: String?) {
        hourLabel.text = text
    }
    
    func configureWeatherImageViewImage(_ image: UIImage?) {
        weatherImageView.image = image?.withTintColor(UIColor(named: "textColor")!, renderingMode: .alwaysOriginal)
    }
    
    func configureTemperatureLabel(_ text: String?) {
        temperatureLabel.text = text
    }
}
