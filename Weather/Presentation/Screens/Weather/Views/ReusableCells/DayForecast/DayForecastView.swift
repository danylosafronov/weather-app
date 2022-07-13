//
//  DayForecastView.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import UIKit

final class DayForecastView: UIView {
    private lazy var hourLabel = UILabel()
    private lazy var weatherImageView = UIImageView()
    private lazy var temperatureLabel = UILabel()
    private lazy var highestTemperatureLabel = UILabel()
    private lazy var lowestTemperatureLabel = UILabel()
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
        configureHighestTemperatureLabelLabel()
        configureLowestTemperatureLabelLabel()
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
        contentStackView.axis = .horizontal
        contentStackView.distribution = .equalSpacing
        contentStackView.alignment = .leading
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.centerYAnchor.constraint(equalTo: contentLayoutGuide.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureHourLabel() {
        contentStackView.addArrangedSubview(hourLabel)
        
        hourLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        hourLabel.numberOfLines = 1
        hourLabel.textColor = UIColor(named: "textColor")
        
        NSLayoutConstraint.activate([
            hourLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.1)
        ])
    }
    
    private func configureWeatherImageView() {
        contentStackView.addArrangedSubview(weatherImageView)
        
        weatherImageView.clipsToBounds = true
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherImageView.heightAnchor.constraint(equalTo: contentLayoutGuide.heightAnchor, multiplier: 0.5),
            weatherImageView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.2),
        ])
    }
    
    private func configureTemperatureLabel() {
        contentStackView.addArrangedSubview(temperatureLabel)
        
        temperatureLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        temperatureLabel.numberOfLines = 1
        temperatureLabel.textColor = UIColor(named: "textColor")
        
        NSLayoutConstraint.activate([
            temperatureLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func configureHighestTemperatureLabelLabel() {
        contentStackView.addArrangedSubview(highestTemperatureLabel)
        
        highestTemperatureLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        highestTemperatureLabel.numberOfLines = 1
        highestTemperatureLabel.textColor = UIColor(named: "textColor")
        
        NSLayoutConstraint.activate([
            highestTemperatureLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.25)
        ])
    }
    
    private func configureLowestTemperatureLabelLabel() {
        contentStackView.addArrangedSubview(lowestTemperatureLabel)
        
        lowestTemperatureLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        lowestTemperatureLabel.numberOfLines = 1
        lowestTemperatureLabel.textColor = UIColor(named: "textColor")
        
        NSLayoutConstraint.activate([
            lowestTemperatureLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.25)
        ])
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
    
    func configureHighestTemperatureLabelText(_ text: String?) {
        highestTemperatureLabel.text = text
    }
    
    func configureLowestTemperatureLabelText(_ text: String?) {
        lowestTemperatureLabel.text = text
    }
}
