//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Welcome to Weather app")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Please share your current location to share the weather")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                // MARK: allow location
            }
            .foregroundColor(.white)
            .cornerRadius(25)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
