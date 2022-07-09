//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Danylo Safronov on 07.07.2022.
//

import UIKit

final class CurrentWeatherView: UIView {
    private lazy var currentLocationLabel = UILabel()
    private lazy var currentTemperatureLabel = UILabel()
    private lazy var currentWeatherLabel = UILabel()
    private lazy var highestTemperatureLabel = UILabel()
    private lazy var lowestTemperatureLabel = UILabel()
    private lazy var contentLayoutGuide = UILayoutGuide()
    private lazy var contentStackView = UIStackView()
    private lazy var extremumContentStackView = UIStackView()
    
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
        configureCurrentLocationLabel()
        configureCurrentTemperatureLabel()
        configureCurrentWeatherLabel()
        configureExtremumContentStackView()
        configureHighestTemperatureLabel()
        configureLowestTemperatureLabel()
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
    
    private func configureCurrentLocationLabel() {
        contentStackView.addArrangedSubview(currentLocationLabel)
        
        currentLocationLabel.font = .systemFont(ofSize: 24.0, weight: .medium)
        currentLocationLabel.numberOfLines = 1
        currentLocationLabel.textColor = UIColor(named: "textColor")
    }
    
    private func configureCurrentTemperatureLabel() {
        contentStackView.addArrangedSubview(currentTemperatureLabel)
        
        currentTemperatureLabel.font = .systemFont(ofSize: 48.0, weight: .medium)
        currentTemperatureLabel.numberOfLines = 1
        currentTemperatureLabel.textColor = UIColor(named: "textColor")
    }
    
    private func configureCurrentWeatherLabel() {
        contentStackView.addArrangedSubview(currentWeatherLabel)
        
        currentWeatherLabel.font = .systemFont(ofSize: 18.0, weight: .medium)
        currentWeatherLabel.numberOfLines = 1
        currentWeatherLabel.textColor = UIColor(named: "textColor")
    }
    
    private func configureExtremumContentStackView() {
        contentStackView.addArrangedSubview(extremumContentStackView)
        
        extremumContentStackView.spacing = 16.0
        extremumContentStackView.axis = .horizontal
        extremumContentStackView.distribution = .fillProportionally
        extremumContentStackView.alignment = .center
    }
    
    private func configureHighestTemperatureLabel() {
        extremumContentStackView.addArrangedSubview(highestTemperatureLabel)
        
        highestTemperatureLabel.font = .systemFont(ofSize: 18.0, weight: .medium)
        highestTemperatureLabel.numberOfLines = 1
        highestTemperatureLabel.textColor = UIColor(named: "textColor")
    }
    
    private func configureLowestTemperatureLabel() {
        extremumContentStackView.addArrangedSubview(lowestTemperatureLabel)
        
        lowestTemperatureLabel.font = .systemFont(ofSize: 18.0, weight: .medium)
        lowestTemperatureLabel.numberOfLines = 1
        lowestTemperatureLabel.textColor = UIColor(named: "textColor")
    }
    
    // MARK: - Actions
    
    func configureCurrentLocationLabelText(_ text: String?) {
        currentLocationLabel.text = text
    }
    
    func configureCurrentTemperatureLabelText(_ text: String?) {
        currentTemperatureLabel.text = text
    }
    
    func configureCurrentWeatherLabelText(_ text: String?) {
        currentWeatherLabel.text = text
    }
    
    func configureHighestTemperatureLabel(_ text: String?) {
        highestTemperatureLabel.text = text
    }
    
    func configureLowestTemperatureLabel(_ text: String?) {
        lowestTemperatureLabel.text = text
    }
}
