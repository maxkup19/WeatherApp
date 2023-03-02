//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import SwiftUI

struct WeatherInfo: View {
    
    let imageName: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: imageName)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color.gray)
                .cornerRadius(25)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.caption)
                
                Text(value)
                    .font(.title)
            }
        }
    }
}

struct WeatherInfo_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfo(imageName: "sun.max", title: "Max temp", value: "12")
    }
}
