//
//  WeatherCard.swift
//  WeatherTrackerApp
//
//  Created by Devangi Shah on 12/20/24.
//

import SwiftUI

struct WeatherCard: View {
    var cityName: String
    var temperature: Double
    var weatherIcon: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(cityName)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(StaticColor.color_black)
                HStack(spacing: 16) {
                    // Temperature
                    HStack(alignment: .top, spacing: 2) {
                        Text(String(format: "%.1f", temperature))
                            .font(.system(size: 60, weight: .medium))
                            .foregroundColor(StaticColor.color_black)
                        
                        Text("°")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(StaticColor.color_black)
                            .offset(y: -8) // Align the ° symbol higher
                    }
                }
            }
            Spacer()
            if let picUrl = URL(string:"\(URLS.https)\(weatherIcon)") {
                    RemoteImage(url: picUrl)
                    .frame(width: BasicValues.height_100, height: BasicValues.height_100)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(StaticColor.color_bg_gray)
        .cornerRadius(BasicValues.cornerRadius_15)
        .padding(.horizontal)
    }
}
