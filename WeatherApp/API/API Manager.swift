//
//  API Manager.swift
//  WeatherApp
//
//  Created by Sawyer Shirley on 11/14/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct APIManager {

    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    
    private let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    static func getWeather(for location: Location, onComplete: @escaping (WeatherData?, Error?) -> Void) {
    //Variables
    
    let key = APIKeys.DarkSkyKey
    let rootURL = "https://api.darksky.net/forecast/"
    
    print(APIKeys.DarkSkyKey)
    
    let url = rootURL + key + "/" + String(location.latitude) + "," + String(location.longitude)
    
    Alamofire.request(url).responseJSON { response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            if let weatherData = WeatherData(json: json) {
                onComplete(weatherData, nil)
            } else {
                onComplete(nil, APIErrors.invalidData)
            }
            
        case .failure(let error):
            onComplete(nil, error)
            }
        }
    }
    
    func geocode(address: String, onCompletion: @escaping (GeocodingData?, Error?) -> Void) {
        let googleURL =  "https://maps.googleapis.com/maps/api/geocode/json?address="
        let url = googleURL + address + "&key=" + APIKeys.googleKey
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let geocodingData = GeocodingData(json: json) {
                    onCompletion(geocodingData, nil) }
                else {
                    onCompletion(nil, APIErrors.invalidData)
                }
                print(json)
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
    }
}
