//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sawyer Shirley on 11/14/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tempStaticLabel: UILabel!
    
    
    var displayWeatherData: WeatherData! {
        didSet {
            iconView.image = displayWeatherData.condition.icon
            tempLabel.text = "\(displayWeatherData.temperature)°"
            highLabel.text = "High: \(displayWeatherData.highTemperature)°"
            lowLabel.text = "Low: \(displayWeatherData.lowTemperature)°"
            weatherLabel.text = displayWeatherData.condition.rawValue
            
            switch displayWeatherData.condition {
            case .partlyCloudyDay:
                weatherLabel.text = "Partly Cloudy Day"
                let layer = CAGradientLayer()
                layer.frame = self.view.bounds
                layer.colors = [UIColor.darkGray.cgColor, UIColor.yellow.cgColor, UIColor.darkGray.cgColor]
                layer.opacity = 1.0
                self.view.layer.insertSublayer(layer, at: 0)
            case .partlyCloudyNight:
                weatherLabel.text = "Partly Cloudy Night"
                let layer = CAGradientLayer()
                layer.frame = self.view.bounds
                layer.colors = [UIColor.blue.cgColor, UIColor.darkGray.cgColor]
                layer.opacity = 1.0
                self.view.layer.insertSublayer(layer, at: 0)
            default:
                return
            }
        }
    }
    
    var displayGeocodingData: GeocodingData! {
        didSet {
            locationLabel.text = displayGeocodingData.formattedAddress
            tempStaticLabel.text = "Temperature:"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let longitude = 37.8267
//        let latitude = -122.4233
        
        setupDefaultUI()
//        APIManager.getWeather(for: (latitude, longitude)) { weatherData, error in
//            if let recievedData = weatherData {
//                self.displayWeatherData = recievedData
//            }
//        }
    }
    
    func setupDefaultUI() {
        locationLabel.text = "Enter a location"
        weatherLabel.text = "-->"
        highLabel.text = ""
        lowLabel.text = ""
        tempLabel.text = ""
        tempStaticLabel.text = ""
    }
    
    @IBAction func unwindToWeatherDisplay(segue: UIStoryboardSegue) { }
        
    
}
    
    

