//
//  WeatherDetail.swift
//  WeatherTrackerApp
//
//  Created by Devangi Shah on 12/20/24.
//

import SwiftUI

struct WeatherDetailView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(StaticColor.color_gray)
                
            Text(value)
                .font(.headline)
                .foregroundColor(StaticColor.color_gray)
        }
    }
}
