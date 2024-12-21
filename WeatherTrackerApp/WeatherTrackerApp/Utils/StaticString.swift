//
//  StaticString.swift
//  WeatherTrackerApp
//
//  Created by Devangi Shah on 12/16/24.
//

import SwiftUICore
import UIKit

struct StaticString{
    static let str_Search_Location = "Search Location"
    static let str_Humidity = "Humidity"
    static let str_UV = "UV"
    static let str_Feels_Like = "Feels Like"
    static let str_No_City_Selected = "No City Selected"
    static let str_Please_Search_For_A_City = "Please Search For A City"
}

struct StaticImage{
    static let img_magnifyingglass = "magnifyingglass"
    static let img_location_fill = "location.fill"
    static let img_circle = "Ellipse 1"
}

struct StaticColor{
    static let color_bg_gray = Color(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0)
    static let color_gray = Color.gray
    static let color_black = Color.black
}

struct BasicValues{
    static let height_50 = 50.0
    static let height_100 = 100.0
    static let height_120 = 120.0
    static let padding_15 = 15.0
    static let padding_5 = 5.0
    static let cornerRadius_15 = 15.0
    static let screenWidth = UIScreen.main.bounds.width
    
}

struct URLS {
    static let aqiValue = "no"
    static let aqiKey = "aqi"
    static let qKey = "q"
    static let apiKey = "key"
    static let apiValue = "910f8be1cea5459fad834242241412"
    static let host = "https://api.weatherapi.com/v1/"
    static let currentWeather = "current.json"
   // static let host = "http://api.weatherapi.com/v1/current.json?key=910f8be1cea5459fad834242241412&q=London&aqi=no"
    static let https = "https:"
}

struct StaticUserDefaultsKeys{
    static let K_searchCity = "searchCity"
    static let K_isShowWeatherDetail = "isShowWeatherDetail"
}
