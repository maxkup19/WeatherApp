//
//  Mock.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import Foundation

enum Mock {
    static let weather: WeatherModel = .init(coord: .init(lon: 1, lat: 1),
                                             weather: [.init(id: 1, main: "", description: "Good")],
                                             main: .init(feels_like: 13,
                                                         temp_min: 10,
                                                         temp_max: 23,
                                                         pressure: 123,
                                                         humidity: 45),
                                             name: "GOOD",
                                             wind: .init(speed: 5))
}
