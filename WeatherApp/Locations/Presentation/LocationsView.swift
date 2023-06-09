//
//  LocationsView.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 08.03.2023.
//

import SwiftUI

struct LocationsView<LocationsVM: LocationsViewModelProtocol>: View {
    
    @Binding var showLocations: Bool
    
    @ObservedObject var viewmodel: LocationsVM
    
    let onLocationTap: ((String) -> Void)?
    
    init(
        viewmodel: LocationsVM,
        showLocations: Binding<Bool>,
        onLocationTap: ((String) -> Void)? = nil
    ) {
        self.viewmodel = viewmodel
        self._showLocations = showLocations
        self.onLocationTap = onLocationTap
    }
    
    var body: some View {
        VStack{
            
            HStack {
                Text("Liked locations")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button {
                    showLocations = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(5)
                }
                
            }
            .frame(maxWidth: .infinity)
            Spacer()
                .frame(maxHeight: 30)
            
            if !viewmodel.locations.isEmpty{
                ForEach($viewmodel.locations, id: \.self) { location in
                    HStack {
                        Image(systemName: "pin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        VStack(alignment: .leading) {
                            Text(location.wrappedValue)
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            viewmodel.removeLocation(location.wrappedValue)
                        } label: {
                            Image(systemName: "trash.fill")
                                .font(.headline)
                                .foregroundColor(.red)
                                .padding(5)
                        }
                        
                    }
                    .onTapGesture {
                        if let onLocationTap {
                            onLocationTap(location.wrappedValue)
                            showLocations = false
                        }
                    }
                }
            } else {
                Spacer()
                Text("Nothing to show")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            Spacer()
        }
    }
}
