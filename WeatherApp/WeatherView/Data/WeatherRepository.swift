//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import Foundation
import Combine

class WeatherRepository: WeatherRepositoryProtocol {
    func fetchWeatherFor(lon: Double, lat: Double) -> AnyPublisher<WeatherModel, WeatherError> {
        
        let urlString = R.Endpoint.coordApi
            .replacing("{lon}", with: "\(lon)")
            .replacing("{lat}", with: "\(lat)")
        
        return makeRequest(for: urlString)
    }
    
    func fetchWeatherFor(city: String) -> AnyPublisher<WeatherModel, WeatherError> {
        let urlString = R.Endpoint.cityApi
            .replacing("{cityname}", with: "\(city)")
        
        print(urlString)
        
        return makeRequest(for: urlString)
    }
    
    private func makeRequest(for urlString: String) -> AnyPublisher<WeatherModel, WeatherError> {
        Just(URL(string: urlString))
            .flatMap { url -> AnyPublisher<URLRequest, WeatherError> in
                guard let url else {
                    return Fail(error: WeatherError.urlCreationFailed)
                        .eraseToAnyPublisher()
                }
                
                return Just(URLRequest(url: url))
                    .setFailureType(to: WeatherError.self)
                    .eraseToAnyPublisher()
            }
            .flatMap { urlRequest in
                URLSession.shared.dataTaskPublisher(for: urlRequest)
                    .mapError(WeatherError.networkError)
                    .eraseToAnyPublisher()
                
            }
            .flatMap { output -> AnyPublisher<Data, WeatherError> in
                
                guard let httpResponse = output.response as? HTTPURLResponse
                else {
                    return Fail(error: WeatherError.apiError)
                        .eraseToAnyPublisher()
                }
                
                guard 200..<300 ~= httpResponse.statusCode
                else {
                    return Fail(error: WeatherError.apiError)
                        .eraseToAnyPublisher()
                }
                
                return Just(output.data)
                    .setFailureType(to: WeatherError.self)
                    .eraseToAnyPublisher()
            }
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .mapError { error in WeatherError.decodingError(error) }
            .print()
            .eraseToAnyPublisher()
    }
}
