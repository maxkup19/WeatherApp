//
//  WeatherError.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import Foundation

enum WeatherError: Error {
    case urlCreationFailed
    case networkError(URLError)
    case authenticationError
    case apiError
    case locationDisabled
    case decodingError(Error)
}
