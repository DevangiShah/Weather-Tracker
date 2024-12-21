//
//  WebAPIManager.swift
//  WeatherTrackerApp
//
//  Created by Devangi Shah on 12/19/24.
//

import SwiftUI
import Combine
import SystemConfiguration

class WebAPIManager: ObservableObject{
    
    private let boundary = "---011000010111000001101001"//"Boundary-\(UUID().uuidString)"\
    
    func isInternetWorking() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }
    
   

    func callGetWeatherMethod(strURL: String,completionHandler:@escaping ((_ receivedData : WeatherDataModel?,_ success: Bool) -> ())){
        
        guard isInternetWorking() else {
            DispatchQueue.main.async {
                print("No Internet Available")
            }
            return
        }
        
        guard let url = URL(string: strURL) else {
            return
        }

        var request = URLRequest(url: url)//, cachePolicy:
        request.timeoutInterval = 300.0
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
               
            if error != nil {
                completionHandler(nil,false)
               return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        print("Invalid response received.")
                    }
                    completionHandler(nil, false)
                    return
            }

            switch httpResponse.statusCode {
            case 200:
                guard let data = data else {
                    completionHandler(nil,false)
                    // print("No data received")
                    return
                }
                do {
                    let decodedUser = try JSONDecoder().decode(WeatherDataModel.self, from: data)
                    DispatchQueue.main.async {
                        print("Response : \(decodedUser)")
                        completionHandler(decodedUser,true)
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        //  self.errorMessage = "Failed to decode response"
                        completionHandler(nil,false)
                    }
                }
            case 401:
                        // Unauthorized - handle token expiration or authentication issue
                DispatchQueue.main.async {
                    print("Unauthorized access. Please log in again.")
                }
            default:
                completionHandler(nil, false)
            }
        }.resume()
    }
}
