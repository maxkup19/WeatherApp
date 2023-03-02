//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var manager = CLLocationManager()
    
    @Published private(set) var isLoasding: Bool = false
    
    var locationEnabled: Bool {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoasding = true
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        isLoasding = false
    }
}
