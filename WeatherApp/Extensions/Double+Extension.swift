//
//  Double+Extension.swift
//  WeatherApp
//
//  Created by Maksym Kupchenko on 03.03.2023.
//

import Foundation

extension Double {
    func roundToString(precision: Int) -> String {
        String(format: "%.\(precision)f", self)
    }
}
