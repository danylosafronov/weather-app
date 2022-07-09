//
//  HourlyForecastView.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import UIKit

final class HourlyForecastView: UIView {
    private lazy var collectionView: UICollectionView! = nil
    private lazy var collectionViewDataSource: UICollectionViewDiffableDataSource<Int, Forecast>! = nil
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
        configureCollectionView()
        configureCollectionViewDataSource()
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
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor(named: "cardBackgroundColor")
        collectionView.register(HourForecastCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, index, item in
            let reusabelCell = collectionView.dequeue(HourForecastCollectionViewCell.self, for: index)
            reusabelCell.configure(for: item)
            
            return reusabelCell
        }
    }
    
    // MARK: - Logic
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { index, _ in
            let spacing = 16.0
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(50.0), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            group.interItemSpacing = .fixed(spacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        }
    }
    
    // MARK: - Actions
    
    func apply(forecasts: LocationForecasts?) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Forecast>()
        if let forecasts = forecasts {
            snapshot.appendSections([.zero])
            snapshot.appendItems(forecasts.forecasts, toSection: .zero)
        }
        
        collectionViewDataSource.apply(snapshot, animatingDifferences: true)
    }
}
