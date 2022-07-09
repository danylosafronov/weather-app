//
//  WeatherCollectionViewCell.swift
//  Weather
//
//  Created by Danylo Safronov on 07.07.2022.
//

import UIKit

class WeatherCollectionViewCell<NestedView>: UICollectionViewCell where NestedView: UIView {
    private (set) lazy var nestedView = NestedView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configure() {
        configureNestedView()
    }
    
    private func configureNestedView() {
        contentView.addSubview(nestedView)
        
        nestedView.clipsToBounds = true
        nestedView.layer.cornerRadius = 10.0
        nestedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nestedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nestedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nestedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nestedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
