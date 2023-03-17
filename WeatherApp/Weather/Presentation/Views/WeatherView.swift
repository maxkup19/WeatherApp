//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import SwiftUI
import CachedAsyncImage

struct WeatherView<WeatherVM: WeatherViewModelProtocol>: View {
    
    @StateObject private var viewmodel: WeatherVM
    
    init(viewmodel: WeatherVM) {
        self._viewmodel = StateObject(wrappedValue: viewmodel)
    }
    
    var body: some View {
        ZStack(alignment: .leading){
            
            VStack{
                title
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .redacted(reason: viewmodel.state == .loading ? .placeholder : [])
                Spacer()
                VStack{
                    feelsLikeSection
                        .redacted(reason: viewmodel.state == .loading ? .placeholder : [])
                    Spacer()
                        .frame(height: 80)
                    cityImage
                        .overlay {
                            if viewmodel.showLoading {
                                LoadingView()
                            }
                        }
                        .onTapGesture { viewmodel.showSearch.toggle() }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            detailSection
            
            if viewmodel.showList {
                LocationsView(viewmodel: LocationsViewModel(), showLocations: $viewmodel.showList) { city in
                    viewmodel.city = city
                    viewmodel.fetchWeatherForCity()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .backgroundStyle(.thinMaterial)
            }
            
        }
        .ignoresSafeArea(edges: [.bottom])
        .background(R.Appearance.color.background)
        .onAppear { withAnimation(.easeInOut) { viewmodel.onAppear()} }
        .onLongPressGesture { withAnimation(.easeInOut) {viewmodel.fetchWeather()} }
        .alert(viewmodel.errorMessage, isPresented: $viewmodel.showError) {
            Button("Ok", role: .cancel, action: {})
        }
        .alert("Search weather in city", isPresented: $viewmodel.showSearch) {
            TextField("Enter city", text: $viewmodel.city)
            
            Button("Cancel", role: .cancel, action: { viewmodel.city = "" })
            Button("Search", action: { withAnimation(.easeInOut) {viewmodel.fetchWeatherForCity()} })
        }
    }
    
    private var title: some View {
        VStack(alignment:  .leading, spacing: 5) {
            HStack {
                Text(viewmodel.weather.name)
                    .bold()
                    .font(.title)
                    .redacted(reason: viewmodel.state == .loading ? .placeholder : [])
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut) {
                        viewmodel.likeButtonTap()
                    }
                } label: {
                    Image(systemName: viewmodel.isCurrentLocationLiked ? "star.fill" : "star")
                }
                .font(.title)
                .tint(.white)
                
                Button {
                    viewmodel.listButtonTap()
                } label: {
                    Image(systemName: "list.star")
                }
                .font(.title)
                .tint(.white)
                
                
            }
            
            Text("\(Date().formatted(.dateTime.month().day().hour().minute())) at \(viewmodel.weather.coord.lat.roundToString(precision: 2))° \(viewmodel.weather.coord.lon.roundToString(precision: 2))°")
                .fontWeight(.light)
            
        }
    }
    
    private var feelsLikeSection: some View {
        HStack {
            VStack(spacing: 20) {
                Image(systemName: viewmodel.getWeatherImage())
                    .font(.system(size: 40))
                
                Text(viewmodel.weather.weather[0].main)
                    .redacted(reason: viewmodel.state == .loading ? .placeholder : [])
                
            }
            .frame(width: 150, alignment: .leading)
            
            Spacer()
            
            Text("\(Int(viewmodel.weather.main.feels_like))°")
                .font(.system(size: 100))
                .fontWeight(.bold)
                .padding()
                .redacted(reason: viewmodel.state == .loading ? .placeholder : [])
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
                                value: "\(Int(viewmodel.weather.main.temp_min.rounded()))°")
                    .redacted(reason: viewmodel.state == .loading ? .placeholder : [])
                    Spacer()
                    
                    WeatherInfo(imageName: "thermometer.high",
                                title: "Max temp",
                                value: "\(Int(viewmodel.weather.main.temp_max.rounded()))°")
                    .redacted(reason: viewmodel.state == .loading ? .placeholder : [])
                    
                    Spacer()
                }
                
                HStack {
                    
                    WeatherInfo(imageName: "wind",
                                title: "Wind speed",
                                value: "\(Int(viewmodel.weather.wind.speed.rounded())) m/s")
                    .redacted(reason: viewmodel.state == .loading ? .placeholder : [])
                    
                    Spacer()
                    
                    WeatherInfo(imageName: "humidity",
                                title: "Humidity",
                                value: "\(Int(viewmodel.weather.main.humidity.rounded())) %")
                    .redacted(reason: viewmodel.state == .loading ? .placeholder : [])
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
