//
//  MainView.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack{
            if locationManager.locationEnabled {
                WeatherView(viewmodel: WeatherViewModel(weatherUC: FetchWeatherUseCase(weatherRepo: WeatherRepository())))
            } else {
                WelcomeView()
                    .environmentObject(locationManager)
            }
        }
        .background(R.Appearance.color.background)
    }
}
