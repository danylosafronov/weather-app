//
//  OWeather.swift
//  Weather
//
//  Created by Danylo Safronov on 09.07.2022.
//

import Foundation

struct OWeather {
    let configuration: OWeatherConfiguration
    
    func fetch(for coordinates: OWeatherCoordinates, in unit: OWeatherUnit) async throws -> OWeatherForecasts {
        let url = try makeForecastUrl(for: coordinates, in: unit)
        let request = URLRequest(url: url)
        
        let (responseData, _) = try await execute(with: request)
        let data = try JSONDecoder().decode(OWeatherForecasts.self, from: responseData)
        
        return data
    }
    
    private func execute(with request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response  else {
                    let error = error ?? OWeatherError.badServerResponse
                    return continuation.resume(throwing: error)
                }

                return continuation.resume(returning: (data, response))
            }
            
            task.resume()
        }
    }
    
    private func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
    }
    
    private func makeForecastUrl(for coordinates: OWeatherCoordinates, in unit: OWeatherUnit) throws -> URL {
        let urlComponents = try makeUrlComponents(
            string: "\(configuration.baseUrl)/forecast",
            parameters: [
                "lat": "\(coordinates.lat)",
                "lon": "\(coordinates.lon)",
                "units": unit.rawValue,
                "appid": configuration.token,
            ]
        )
        
        guard let url = urlComponents.url else { throw OWeatherError.invalidUrl }
        return url
    }
    
    private func makeUrlComponents(string: String, parameters: [String: String] = [:]) throws -> URLComponents {
        guard var urlComponents = URLComponents(string: string) else {
            throw OWeatherError.malformedUrl
        }
        
        urlComponents.queryItems = parameters.map { .init(name: $0.key, value: $0.value) }
        return urlComponents
    }
}
