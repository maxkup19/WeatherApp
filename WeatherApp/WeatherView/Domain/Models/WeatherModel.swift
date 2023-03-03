//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import Foundation

struct WeatherModel: Decodable {
    var coord: Coordinates
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct Coordinates: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
    }
    
    struct MainResponse: Decodable {
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
    }
}

