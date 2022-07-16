//
//  Container.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

@MainActor struct Container {
    private func makeOWeather() -> OWeather {
        OWeather(
            configuration: .init(
                token: Configuration.requiredString(byKey: "API_KEY")
            )
        )
    }
    
    private func makeForecastNetworkDataSource() -> ForecastNetworkDataSource {
        DefaultForecastNetworkDataSource(oweather: makeOWeather())
    }
    
    private func makeForecastCacheNetworkDataSource() -> ForecastCacheDataSource {
        DefaultForecastCacheDataSource(contaner: PersistenceController.shared.container)
    }
    
    private func makeForecastRepository() -> ForecastRepository {
        DefaultForecastRepository(
            networkDataSource: makeForecastNetworkDataSource(),
            cacheDataSource: makeForecastCacheNetworkDataSource()
        )
    }
    
    private func makeGetLocationForecasts() -> GetLocationForecastsUseCase {
        DefaultGetLocationForecastsUseCase(repository: makeForecastRepository())
    }

    private func makeResolveLocationForecastUseCase() -> ResolveCurrentLocationForecastsUseCase {
        DefaultResolveCurrentLocationForecastsUseCase(
            resolveDayForecastUseCase: makeResolveDayForecastUseCase()
        )
    }
    
    private func makeResolveHourlyLocationForecastsUseCase() -> ResolveHourlyLocationForecastsUseCase {
        DefaultResolveHourlyLocationForecastsUseCase()
    }
    
    private func makeResolveDailyLocationForecastsUseCase() -> ResolveDailyLocationForecastsUseCase {
        DefaultResolveDailyLocationForecastsUseCase(
            resolveDayForecastUseCase: makeResolveDayForecastUseCase()
        )
    }
    
    private func makeResolveDayForecastUseCase() -> ResolveDayForecastUseCase {
        DefaultResolveDayForecastUseCase()
    }
    
    private func makeGetForecastsUseCase() -> GetForecastsUseCase {
        DefaultGetForecastsUseCase(
            getLocationForecasts: makeGetLocationForecasts(),
            resolveCurrentLocationForecastsUseCase: makeResolveLocationForecastUseCase(),
            resolveHourlyLocationForecastsUseCase: makeResolveHourlyLocationForecastsUseCase(),
            resolveDailyLocationForecastsUseCase: makeResolveDailyLocationForecastsUseCase()
        )
    }
    
    func makeWeatherViewModel() -> WeatherViewModel {
        WeatherViewModel(getForecasts: makeGetForecastsUseCase())
    }
}
