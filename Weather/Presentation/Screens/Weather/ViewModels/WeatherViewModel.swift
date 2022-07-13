//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import Foundation

@MainActor final class WeatherViewModel {
    @Published private (set) var locationForecast: LocationForecasts? = nil
    @Published private (set) var hourlyForecast: LocationForecasts? = nil
    @Published private (set) var dailyForecast: LocationForecasts? = nil
    
    private var task: Task<Void, Error>?
    private let getForecasts: GetForecastsUseCase
    
    init(getForecasts: GetForecastsUseCase) {
        self.getForecasts = getForecasts
    }
    
    public func load(coordinates: Coordinates? = nil) {
        task?.cancel()
        task = Task { [weak self] in
            guard let self = self else { return }
            
            await self.loadAsync(coordinates: coordinates)
            self.task = nil
        }
    }
    
    private func loadAsync(coordinates: Coordinates?) async {
        do {
            let (locationForecast, hourlyForecast, dailyForecast) = try await getForecasts.invoke(for: coordinates)

            guard !Task.isCancelled else { return }

            self.locationForecast = locationForecast
            self.hourlyForecast = hourlyForecast
            self.dailyForecast = dailyForecast
        } catch {
            print(error)
        }
    }
}
