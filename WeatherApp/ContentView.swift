//
//  ContentView.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack{
            if locationManager.locationEnabled {
                WeatherView(weathervm: WeatherViewModel(weatherUC: FetchWeatherUseCase(weatherRepo: WeatherRepository())))
            } else {
                WelcomeView()
                    .environmentObject(locationManager)
            }
        }
        .background(R.Appearance.color.background)
        .preferredColorScheme(.dark)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
