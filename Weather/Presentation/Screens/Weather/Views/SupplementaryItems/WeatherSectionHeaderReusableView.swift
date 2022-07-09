//
//  WeatherSectionBackroundReusableView.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import UIKit

final class WeatherSectionHeaderReusableView: UICollectionReusableView {
    private lazy var nestedView = WeatherSectionHeaderView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionReusableView lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        configure(title: nil)
    }
    
    // MARK: - Configuration
    
    private func configure() {
        configureNestedView()
    }
    
    private func configureNestedView() {
        addSubview(nestedView)
        
        nestedView.clipsToBounds = true
        nestedView.layer.cornerRadius = 10.0
        nestedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nestedView.topAnchor.constraint(equalTo: topAnchor),
            nestedView.bottomAnchor.constraint(equalTo: bottomAnchor),
            nestedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nestedView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    // MARK: - Actions
    
    func configure(title: String?) {
        nestedView.configureTitleLabelText(title)
    }
}
