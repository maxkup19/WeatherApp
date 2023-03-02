//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .background(R.Appearance.color.background)
                .preferredColorScheme(.dark)
        }
    }
}
