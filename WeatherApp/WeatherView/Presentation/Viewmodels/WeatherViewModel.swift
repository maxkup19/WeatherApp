//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import SwiftUI
import Combine

protocol WeatherViewModelProtocol: ObservableObject {
    var weather: WeatherModel { get }
    var currentTime: String { get }
    var city: String { get set }
    
    var state: FetchState { get }
    var showLoading: Bool { get }
    var showSearch: Bool {  get set }
    var showError: Bool { get set }
    var errorMessage: String { get }
    
    func onAppear()
    func fetchWeather()
    func fetchWeatherForCity()
    func getWeatherImage() -> String
}

class WeatherViewModel: WeatherViewModelProtocol {
    
    @Published private(set) var weather: WeatherModel = Mock.weather
    @Published private(set) var currentTime: String = "\(Date().formatted(.dateTime.month().day().hour().minute()))"
    @Published var city: String = ""
    
    @Published private(set) var showLoading: Bool = false
    @Published private(set) var state: FetchState = .none
    @Published private(set) var errorMessage: String = ""
    @Published var showSearch: Bool = false
    @Published var showError: Bool = false
    
    private let weatherUC: FetchWeatherUseCaseProtocol
    private var bag = Set<AnyCancellable>()
    
    init(weatherUC: FetchWeatherUseCaseProtocol) {
        self.weatherUC = weatherUC
    }
    
    func onAppear() {
        fetchWeather()
    }
    
    func fetchWeather() {
        self.state = .loading
        self.showLoading = true
        updateTime()
        weatherUC.fetchWeather()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                    switch completion {
                    case .finished:
                        self.state = .success
                    case .failure(_):
                        self.errorMessage = "Oops... Try one more time"
                        self.state = .error
                        self.showError = true
                    }
                    self.showLoading = false
                }
            } receiveValue: { [weak self] weather in
                guard let self else { return }

                self.weather = weather
            }
            .store(in: &bag)
    }
    
    func fetchWeatherForCity() {
        self.state = .loading
        self.showLoading = true
        updateTime()
        weatherUC.fetchWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                    switch completion {
                    case .finished:
                        self.state = .success
                        self.city = ""
                    case .failure(_):
                        self.errorMessage = "Invalid city name"
                        self.state = .error
                        self.showError = true
                    }
                    self.showLoading = false
                }
            } receiveValue: { [weak self] weather in
                guard let self else { return }

                self.weather = weather
            }
            .store(in: &bag)
    }
    
    func getWeatherImage() -> String {
        switch weather.weather.first?.main {
        case "Thunderstorm":
            return "cloud.bolt.rain.fill"
        case "Drizzle":
            return "cloud.drizzle.fill"
        case "Rain":
            return "cloud.rain.fill"
        case "Snow":
            return "snowflake"
        case "Clear":
            return "sun.max"
        case "Clouds":
            return "cloud.fill"
        default:
            return "hurricane"
        }
    }
}

private extension WeatherViewModel {
    func updateTime() {
        self.currentTime = "\(Date().formatted(.dateTime.month().day().hour().minute()))"
    }
}
