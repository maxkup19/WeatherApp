//
//  FetchWeatherUseCase.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import CoreLocation
import Combine

protocol FetchWeatherUseCaseProtocol {
    func fetchWeather() -> AnyPublisher<WeatherModel, WeatherError>
    func fetchWeather(for city: String) -> AnyPublisher<WeatherModel, WeatherError>
}

final class FetchWeatherUseCase: FetchWeatherUseCaseProtocol {
    
    private let weatherRepo: WeatherRepositoryProtocol
    private let locationManager = LocationManager()
    
    init(weatherRepo: WeatherRepositoryProtocol) {
        self.weatherRepo = weatherRepo
    }
    
    func fetchWeather() -> AnyPublisher<WeatherModel, WeatherError> {
                
        guard let coordinates = locationManager.manager.location?.coordinate else {
            return Fail(error: WeatherError.locationDisabled)
                .eraseToAnyPublisher()
        }
        return weatherRepo.fetchWeatherFor(lon: coordinates.longitude, lat: coordinates.latitude)
    }
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherModel, WeatherError> {
        weatherRepo.fetchWeatherFor(city: city.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
}
