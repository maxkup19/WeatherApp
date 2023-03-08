//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import SwiftUI
import CachedAsyncImage

struct WeatherView<WeatherVM: WeatherViewModelProtocol>: View {
    
    @StateObject private var weathervm: WeatherVM
    
    init(weathervm: WeatherVM) {
        self._weathervm = StateObject(wrappedValue: weathervm)
    }
    
    var body: some View {
        ZStack(alignment: .leading){
            
            VStack{
                title
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .redacted(reason: weathervm.state == .loading ? .placeholder : [])
                Spacer()
                VStack{
                    feelsLikeSection
                        .redacted(reason: weathervm.state == .loading ? .placeholder : [])
                    Spacer()
                        .frame(height: 80)
                    cityImage
                        .overlay {
                            if weathervm.showLoading {
                                LoadingView()
                            }
                        }
                        .onTapGesture { weathervm.showSearch.toggle() }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            detailSection
            
        }
        .ignoresSafeArea(edges: [.bottom])
        .background(R.Appearance.color.background)
        .onAppear { withAnimation(.easeInOut) {weathervm.onAppear()} }
        .onLongPressGesture { withAnimation(.easeInOut) {weathervm.fetchWeather()} }
        .alert(weathervm.errorMessage, isPresented: $weathervm.showError) {
            Button("Ok", role: .cancel, action: {})
        }
        .alert("Search weather in city", isPresented: $weathervm.showSearch) {
            TextField("Enter city", text: $weathervm.city)
            
            Button("Cancel", role: .cancel, action: { weathervm.city = "" })
            Button("Search", action: { withAnimation(.easeInOut) {weathervm.fetchWeatherForCity()} })
        }
    }
    
    private var title: some View {
        VStack(alignment:  .leading, spacing: 5) {
            HStack {
                Text(weathervm.weather.name)
                    .bold()
                    .font(.title)
                    .redacted(reason: weathervm.state == .loading ? .placeholder : [])
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut) {
                        weathervm.likeButtonTap()
                    }
                } label: {
                    Image(systemName: weathervm.isCurrentLocationLiked ? "star" : "star.fill")
                }
                .font(.title)
                .tint(.white)
                
                Button {
                    
                } label: {
                    Image(systemName: "list.star")
                }
                .font(.title)
                .tint(.white)


            }
            
            Text("\(Date().formatted(.dateTime.month().day().hour().minute())) at \(weathervm.weather.coord.lat.roundToString(precision: 2))° \(weathervm.weather.coord.lon.roundToString(precision: 2))°")
                .fontWeight(.light)
            
        }
    }
    
    private var feelsLikeSection: some View {
        HStack {
            VStack(spacing: 20) {
                Image(systemName: weathervm.getWeatherImage())
                    .font(.system(size: 40))
                
                Text(weathervm.weather.weather[0].main)
                    .redacted(reason: weathervm.state == .loading ? .placeholder : [])
                
            }
            .frame(width: 150, alignment: .leading)
            
            Spacer()
            
            Text("\(Int(weathervm.weather.main.feels_like))°")
                .font(.system(size: 100))
                .fontWeight(.bold)
                .padding()
                .redacted(reason: weathervm.state == .loading ? .placeholder : [])
        }
    }
    
    private var cityImage: some View {
        CachedAsyncImage(url: URL(string: R.Appearance.style.backgroundImageUrl)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
            default:
                ProgressView()
            }
        }
    }
    
    private var detailSection: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Weather now")
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                HStack {
                    
                    WeatherInfo(imageName: "thermometer.low",
                                title: "Min temp",
                                value: "\(Int(weathervm.weather.main.temp_min.rounded()))°")
                    .redacted(reason: weathervm.state == .loading ? .placeholder : [])
                    Spacer()
                    
                    WeatherInfo(imageName: "thermometer.high",
                                title: "Max temp",
                                value: "\(Int(weathervm.weather.main.temp_max.rounded()))°")
                    .redacted(reason: weathervm.state == .loading ? .placeholder : [])
                    
                    Spacer()
                }
                
                HStack {
                    
                    WeatherInfo(imageName: "wind",
                                title: "Wind speed",
                                value: "\(Int(weathervm.weather.wind.speed.rounded())) m/s")
                    .redacted(reason: weathervm.state == .loading ? .placeholder : [])
                    
                    Spacer()
                    
                    WeatherInfo(imageName: "humidity",
                                title: "Humidity",
                                value: "\(Int(weathervm.weather.main.humidity.rounded())) %")
                    .redacted(reason: weathervm.state == .loading ? .placeholder : [])
                    Spacer()
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.bottom, 20)
            .foregroundColor(.black)
            .background(.white)
            .cornerRadius(20)
        }
    }
}
