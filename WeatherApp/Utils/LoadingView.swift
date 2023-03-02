//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 02.03.2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(
                tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(R.Appearance.color.background)
        
    }
}

#if DEBUG
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
#endif
