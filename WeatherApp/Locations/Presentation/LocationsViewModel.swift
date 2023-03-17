//
//  LocationsViewModel.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 10.03.2023.
//

import SwiftUI

protocol LocationsViewModelProtocol: ObservableObject {
    var locations: [String] { get set }
    
    func removeLocation(_ location: String)
}

class LocationsViewModel: LocationsViewModelProtocol {
    @AppStorage("likedLocations") var locations: [String] = []
    
    func removeLocation(_ location: String) {
        locations.removeAll(where: { $0 == location })
    }
}
