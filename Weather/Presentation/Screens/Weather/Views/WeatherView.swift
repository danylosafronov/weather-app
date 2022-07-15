//
//  WeatherView.swift
//  Weather
//
//  Created by Danylo Safronov on 07.07.2022.
//

import UIKit

final class WeatherView: UIView {
    private enum Section: Int, CaseIterable {
        case current
        case hourly
        case daily
    }
    
    private lazy var backgroundView = UIView()
    private lazy var collectionView: UICollectionView! = nil
    private lazy var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, LocationForecasts>! = nil
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
        configureBackgroundView()
        configureContentLayoutGuide()
        configureCollectionView()
        configureCollectionViewDataSource()
    }
    
    private func configureBackgroundView() {
        addSubview(backgroundView)
        
        backgroundView.backgroundColor = UIColor(named: "backgroundColor")
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func configureContentLayoutGuide() {
        addLayoutGuide(contentLayoutGuide)
        
        NSLayoutConstraint.activate([
            contentLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentLayoutGuide.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentLayoutGuide.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        addSubview(collectionView)
        
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        collectionView.register(CurrentWeatherCollectionViewCell.self)
        collectionView.register(HourlyForecastCollectionViewCell.self)
        collectionView.register(DailyForecastCollectionViewCell.self)
        collectionView.register(WeatherSectionHeaderReusableView.self, of: ElementKind.sectionHeader)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configureCollectionViewDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { [weak self] collectionView, index, item in
            guard
                let self = self,
                let section = Section(rawValue: index.section)
            else {
                return nil
            }
                        
            return self.resolveCollectionViewCell(collectionView, in: index, for: item, by: section)
        }
        
        collectionViewDataSource.supplementaryViewProvider = { [weak self] collectionView, kind, index in
            guard
                let self = self,
                let section = Section(rawValue: index.section)
            else {
                return nil
            }
            
            return self.resolveCollectionViewSupplementaryItem(collectionView, of: kind, for: index, by: section)
        }
    }
    
    // MARK: - Logic
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] index, _ in
            guard
                let self = self,
                let section = Section(rawValue: index)
            else {
                return nil
            }
            
            return self.resolveCollectionViewSectionLayout(section: section)
        }
        
        layout.register(WeatherSectionBackroundReusableView.self, forDecorationViewOfKind: ElementKind.background)
        return layout
    }
    
    private func resolveCollectionViewSectionLayout(section: Section) -> NSCollectionLayoutSection {
        let spacing = 16.0
        
        switch section {
        case .current: return makeCollectionViewSectionLayout(spacing: spacing, columnCount: 1, groupHeight: 300.0)
        case .hourly, .daily:
            let height = section == .hourly ? 125.0 : 325.0
            let section = makeCollectionViewSectionLayout(spacing: spacing, columnCount: 1, groupHeight: height)
            
            let headerHeight = 44.0
            let header = makeCollectionViewSectionHeader(height: 44.0, offset: spacing)
            section.boundarySupplementaryItems = [header]
            
            let background = makeCollectionViewSectionBackground(spacing: spacing)
            section.decorationItems = [background]
            section.contentInsets = NSDirectionalEdgeInsets(top: spacing + headerHeight, leading: spacing, bottom: spacing, trailing: spacing)
            
            return section
        }
    }
    
    private func makeCollectionViewSectionLayout(spacing: CGFloat, columnCount: Int, groupHeight: Double) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columnCount)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        return section
    }
    
    private func makeCollectionViewSectionBackground(spacing: CGFloat) -> NSCollectionLayoutDecorationItem {
        let background = NSCollectionLayoutDecorationItem.background(elementKind: ElementKind.background)
        background.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        return background
    }
    
    private func makeCollectionViewSectionHeader(height: CGFloat, offset: CGFloat) -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height))
        let absoluteOffset = CGPoint(x: .zero, y: height + offset)
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size, elementKind: ElementKind.sectionHeader, alignment: .top, absoluteOffset: absoluteOffset)
        header.pinToVisibleBounds = true
        
        return header
    }
    
    private func resolveCollectionViewCell(_ collectionView: UICollectionView, in index: IndexPath, for item: LocationForecasts, by section: Section) -> UICollectionViewCell? {
        switch section {
        case .current:
            return resolveCurrentWeatherCollectionViewCell(collectionView, in: index, for: item)
            
        case .hourly:
            return resolveHourlyWeatherCollectionViewCell(collectionView, in: index, for: item)
            
        case .daily:
            return resolveDailyWeatherCollectionViewCell(collectionView, in: index, for: item)
        }
    }
    
    private func resolveCollectionViewSupplementaryItem(_ collectionView: UICollectionView, of kind: String, for index: IndexPath, by section: Section) -> UICollectionReusableView? {
        switch kind {
        case ElementKind.sectionHeader:
            let reusableSupplementaryView = collectionView.dequeue(WeatherSectionHeaderReusableView.self, of: ElementKind.sectionHeader, for: index)
            let sectionTitle = resolveCollectionViewSectionTitle(by: section)
            reusableSupplementaryView.configure(title: sectionTitle)
            
            return reusableSupplementaryView
            
        default:
            return nil
        }
    }
    
    private func resolveCollectionViewSectionTitle(by section: Section) -> String? {
        switch section {
        case .hourly:
            return "Hourly forecast".uppercased()
            
        case .daily:
            return "5-day forecast".uppercased()
            
        default:
            return nil
        }
    }
    
    private func resolveCurrentWeatherCollectionViewCell(_ collectionView: UICollectionView, in index: IndexPath, for item: LocationForecasts) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeue(CurrentWeatherCollectionViewCell.self, for: index)
        reusableCell.configure(for: item)
        
        return reusableCell
    }
    
    private func resolveHourlyWeatherCollectionViewCell(_ collectionView: UICollectionView, in index: IndexPath, for item: LocationForecasts) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeue(HourlyForecastCollectionViewCell.self, for: index)
        reusableCell.configure(for: item)
        
        return reusableCell
    }
    
    private func resolveDailyWeatherCollectionViewCell(_ collectionView: UICollectionView, in index: IndexPath, for item: LocationForecasts) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeue(DailyForecastCollectionViewCell.self, for: index)
        reusableCell.configure(for: item)
        
        return reusableCell
    }
    
    // MARK: - Actions
    
    func apply(locationForecast: LocationForecasts?, hourlyForecasts: LocationForecasts?, dailyForecasts: LocationForecasts?) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, LocationForecasts>()
        if let locationForecast = locationForecast {
            snapshot.appendSections([.current])
            snapshot.appendItems([locationForecast], toSection: .current)
        }
        
        if let hourlyForecasts = hourlyForecasts {
            snapshot.appendSections([.hourly])
            snapshot.appendItems([hourlyForecasts], toSection: .hourly)
        }
        
        if let dailyForecasts = dailyForecasts {
            snapshot.appendSections([.daily])
            snapshot.appendItems([dailyForecasts], toSection: .daily)
        }
        
        collectionViewDataSource.apply(snapshot, animatingDifferences: true)
    }
}
