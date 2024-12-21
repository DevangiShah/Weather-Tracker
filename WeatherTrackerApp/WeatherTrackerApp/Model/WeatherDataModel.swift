//
//  WeatherDataModel.swift
//  WeatherTrackerApp
//
//  Created by Devangi Shah on 12/16/24.
//

import Foundation

struct WeatherDataModel:Codable{
    var location: WeatherLocation?
    var current: WeatherCurrent?
}

// MARK: - Location
struct WeatherLocation: Codable {
    var name: String?
    var region: String?
    var country: String?
    var lat: Double?
    var lon: Double?
    var tzID: String?
    var localtimeEpoch: Int?
    var localtime: String?

    // Map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

// MARK: - Current
struct WeatherCurrent: Codable {
    var tempC: Double?
    var condition: Condition?
    var humidity: Int?
    var feelslikeC: Double?
    var uv: Double?

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition, humidity
        case feelslikeC = "feelslike_c"
        case uv
    }
}

// MARK: - Condition
struct Condition: Codable {
    var icon: String?
    var code: Int?
}

