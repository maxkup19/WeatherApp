//
//  Resources.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import SwiftUI

typealias R = Resources

enum Resources {
    enum Appearance {
        enum color {
            static let background = Color.cyan //Color(hue: 0.656, saturation: 0.787, brightness: 0.354)
        }
        
        enum style {
            static let backgroundImageUrl = "https://cdn.pixabay.com/photo/2022/07/04/12/48/buildings-7301094_1280.png"
        }
    }
    
    enum Endpoint {
        static let coordApi: String = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&units=metric&appid=7924a7177e99e98a66b580200a3e7d39"
        
        static let cityApi: String = "https://api.openweathermap.org/data/2.5/weather?q={cityname}&units=metric&appid=7924a7177e99e98a66b580200a3e7d39"
        
    }
    
}
