//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Sawyer Shirley on 11/16/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherData {
    
    enum Condition: String {
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
        
        
        var icon: UIImage {
            switch self {
            case .clearDay:
                return UIImage(named: "sunClear")!
            case .clearNight:
                return UIImage(named: "moonClear")!
            case .cloudy:
                return UIImage(named: "cloud")!
            case .partlyCloudyDay:
                return UIImage(named: "sunClear")!
            case .partlyCloudyNight:
                return UIImage(named: "moonClear")!
            case .snow:
                return UIImage(named: "snowflakes")!
            case .sleet:
                return UIImage(named: "snowflakes")!
            case .fog:
                return UIImage(named: "cloud")!
            case .rain:
                return UIImage(named: "raindrops")!
            case .wind:
                return UIImage(named: "wind")!
            }
        }
    }
    
    enum WeatherDataKeys: String {
        case currently = "currently"
        case temperature = "temperature"
        case icon = "icon"
        case daily = "daily"
        case date = "date"
        case temperatureHigh = "temperatureHigh"
        case temperatureLow = "temperatureLow"
        case data = "data"
    }
    
    let temperature: Double
    let highTemperature: Double
    let lowTemperature: Double
    let condition: Condition
    
    //Designated Initializer
    init(temperature: Double, highTemperature: Double, lowTemperature: Double, condition: Condition) {
        self.temperature = temperature
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
        self.condition = condition
    }
    
    convenience init?(json: JSON) {
        guard let temperature = json[WeatherDataKeys.currently.rawValue]     [WeatherDataKeys.temperature.rawValue].double else {
                return nil
        }
        
        guard let highTemperature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0] [WeatherDataKeys.temperatureHigh.rawValue].double else {
            return nil
        }
        
        guard let lowTemperature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0] [WeatherDataKeys.temperatureLow.rawValue].double else {
            return nil
        }
        
        guard let conditionString = json[WeatherDataKeys.currently.rawValue] [WeatherDataKeys.icon.rawValue].string else {
            return nil
        }
        
        guard let condition = Condition(rawValue: conditionString) else {
            //print("GOT THE CONDITION")
            return nil
        }
        
        self.init(temperature: temperature, highTemperature: highTemperature, lowTemperature: lowTemperature, condition: condition)
        
    }
}







