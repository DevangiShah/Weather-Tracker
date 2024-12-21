//
//  ContentView.swift
//  WeatherTrackerApp
//
//  Created by Devangi Shah on 12/15/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @AppStorage(StaticUserDefaultsKeys.K_searchCity) private var strCity: String = ""
    @State private var dictWeatherDetails = WeatherDataModel()
    @ObservedObject var webAPIManager = WebAPIManager()
    @State private var isShowingNoSelectedCity: Bool = true
    @AppStorage(StaticUserDefaultsKeys.K_isShowWeatherDetail) private var isShowingWeatherDetail: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Search bar
            HStack {
                TextField(StaticString.str_Search_Location, text: $strCity)
                   .padding(.leading, BasicValues.padding_15)
                    .frame(height: BasicValues.height_50)
                    .onSubmit {
                        if !strCity.isEmpty {
                            getWeatherInfo()
                        }
                    }
                Image(systemName: StaticImage.img_magnifyingglass)
                .foregroundColor(StaticColor.color_gray)
                .padding(.trailing, BasicValues.padding_15)
            }
            //.padding()
            .padding(.top,BasicValues.padding_5)
            .background(StaticColor.color_bg_gray)
            .cornerRadius(BasicValues.cornerRadius_15)
            .padding(.horizontal)
            
            if isShowingWeatherDetail{
                // Weather Icon
                Spacer()
                if let iconString = dictWeatherDetails.current?.condition?.icon{
                    if let picUrl = URL(string:"\(URLS.https)\(iconString)") {
                            RemoteImage(url: picUrl)
                        // .aspectRatio(contentMode: .fill)
                            .frame(width: BasicValues.height_120, height: BasicValues.height_120)
                    }
                }
                // Location Name
                HStack(spacing: 5) {
                    Text(dictWeatherDetails.location?.name ?? "")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(StaticColor.color_black)
                    
                    Image(systemName:StaticImage.img_location_fill) // Arrow/Icon after the text
                        .font(.system(size: 20)) // Adjust the size of the arrow
                        .foregroundColor(StaticColor.color_black)
                }
                
                // Location Name
                HStack(alignment: .top, spacing: 2) {
                    Text(String(format: "%.1f", dictWeatherDetails.current?.tempC ?? 0.0))
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(StaticColor.color_black)
                    
                    /*Image(StaticImage.img_circle) // Use a filled circle to represent °
                        .resizable()
                    .frame(width: 10, height: 10)
                    .scaledToFit()
                    .foregroundColor(StaticColor.color_black)
                    .padding(.top, 8) // Align it slightly higher
                    .padding(.leading, 10)*/
                    
                    Text("°")
                        .font(.system(size: 50, weight: .ultraLight))
                    .foregroundColor(StaticColor.color_black)
                    .offset(y: -8) // Align the ° symbol higher
                }
                // Weather Details Section
                HStack() {
                    WeatherDetailView(title: StaticString.str_Humidity, value: "\(dictWeatherDetails.current?.humidity ?? 0)%")
                    .frame(maxWidth: .infinity)
                   
                    WeatherDetailView(title: StaticString.str_UV, value: String(format: "%.1f", dictWeatherDetails.current?.uv ?? 0.0))
                    .frame(maxWidth: .infinity)
                    
                    WeatherDetailView(title: StaticString.str_Feels_Like, value: String(format: "%.1f°", dictWeatherDetails.current?.feelslikeC ?? 0.0))
                    .frame(maxWidth: .infinity)
                
                }
                .frame(maxWidth: BasicValues.screenWidth - 150, maxHeight: BasicValues.height_50)
                .padding()
                .background(StaticColor.color_bg_gray)
                .cornerRadius(BasicValues.cornerRadius_15)
                Spacer()
                Spacer()
            }
            else if strCity == "" {
                Spacer()
                // "No City Selected" text
                Text(StaticString.str_No_City_Selected)
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundColor(StaticColor.color_black)
                Text(StaticString.str_Please_Search_For_A_City)
                    .font(.system(size: 16, weight: .medium))
                .foregroundColor(StaticColor.color_black)
                Spacer()
            }
            else{
                if let weatherLocation = dictWeatherDetails.location {
                    WeatherCard(cityName: weatherLocation.name ?? "", temperature: dictWeatherDetails.current?.tempC ?? 0.0, weatherIcon: dictWeatherDetails.current?.condition?.icon ?? "")
                        .onTapGesture {
                            isShowingWeatherDetail = true
                        }
                    Spacer()
                }
                else{
                    HStack() {
                        
                    }
                }
            }
            
        }
        .onAppear{
            if !strCity.isEmpty {
                getWeatherInfo()
            }
        }
        .padding()
    }
    
    func getWeatherInfo(){
        if webAPIManager.isInternetWorking(){
            
            dictWeatherDetails = WeatherDataModel()
            isShowingWeatherDetail = false
            
            let strGenerateAPI = "\(URLS.host)\(URLS.currentWeather)?\(URLS.apiKey)=\(URLS.apiValue)&\(URLS.qKey)=\(strCity)&\(URLS.aqiKey)=\(URLS.aqiValue)"
            
            webAPIManager.callGetWeatherMethod(strURL: strGenerateAPI) { receivedData, isSuccess in
                if (isSuccess){
                    dictWeatherDetails = receivedData ?? WeatherDataModel()
                }
            }
        }
        
    }
    
    func saveCityName(_ cityName: String) {
        UserDefaults.standard.set(cityName, forKey: StaticUserDefaultsKeys.K_searchCity)
    }
    
    func getCityName() -> String {
        return UserDefaults.standard.string(forKey: StaticUserDefaultsKeys.K_searchCity) ?? ""
    }
    
    func saveShowWeatherDetailValue(_isShow : Bool) {
        UserDefaults.standard.set(_isShow, forKey: StaticUserDefaultsKeys.K_isShowWeatherDetail)
    }
    
    func getShowWeatherDetailValue() -> Bool {
        return UserDefaults.standard.bool(forKey: StaticUserDefaultsKeys.K_isShowWeatherDetail)
    }
}

#Preview {
    ContentView()
}
