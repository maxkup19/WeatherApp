//
//  Mock.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import Foundation

enum Mock {
    static let weather: WeatherModel = .init(weather: [.init(id: 1, main: "", description: "Good", icon: "")],
                                             main: .init(temp: 12.0,
                                                         feels_like: 13,
                                                         temp_min: 10,
                                                         temp_max: 23,
                                                         pressure: 123,
                                                         humidity: 45),
                                             name: "GOOD",
                                             wind: .init(speed: 5,
                                                         deg: 123))
}
