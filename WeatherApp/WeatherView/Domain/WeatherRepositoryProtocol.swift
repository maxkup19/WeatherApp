//
//  WeatherRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import Combine

protocol WeatherRepositoryProtocol {
    func fetchWeatherFor(lon: Double, lat: Double) -> AnyPublisher<WeatherModel, WeatherError>
    func fetchWeatherFor(city: String) -> AnyPublisher<WeatherModel, WeatherError>
}
