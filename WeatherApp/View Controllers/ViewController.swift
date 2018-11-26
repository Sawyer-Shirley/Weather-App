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
    
    var layer = CAGradientLayer()
    
    
    var displayWeatherData: WeatherData! {
        didSet {
            iconView.image = displayWeatherData.condition.icon
            tempLabel.text = "\(displayWeatherData.temperature)°"
            highLabel.text = "High: \(displayWeatherData.highTemperature)°"
            lowLabel.text = "Low: \(displayWeatherData.lowTemperature)°"
            weatherLabel.text = displayWeatherData.condition.rawValue
            
            switch displayWeatherData.condition {
            case .partlyCloudyDay:
                layer.removeFromSuperlayer()
                weatherLabel.text = "Partly Cloudy Day"
                layer = CAGradientLayer()
                layer.frame = self.view.bounds
                layer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
                layer.opacity = 1.0
                self.view.layer.insertSublayer(layer, at: 0)
            case .partlyCloudyNight:
                layer.removeFromSuperlayer()
                weatherLabel.text = "Partly Cloudy Night"
                layer = CAGradientLayer()
                layer.frame = self.view.bounds
                layer.colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor]
                layer.opacity = 1.0
                self.view.layer.insertSublayer(layer, at: 0)
            case .clearDay:
                layer.removeFromSuperlayer()
                weatherLabel.text = "Clear Day"
                layer = CAGradientLayer()
                layer.frame = self.view.bounds
                layer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
                layer.opacity = 1.0
                self.view.layer.insertSublayer(layer, at: 0)
            case .cloudy:
                layer.removeFromSuperlayer()
                weatherLabel.text = "Cloudy"
                layer = CAGradientLayer()
                layer.frame = self.view.bounds
                layer.colors = [UIColor.gray.cgColor, UIColor.white.cgColor]
                layer.opacity = 1.0
                self.view.layer.insertSublayer(layer, at: 0)
            case .rain:
                layer.removeFromSuperlayer()
                weatherLabel.text = "Rainy"
                layer = CAGradientLayer()
                layer.frame = self.view.bounds
                layer.colors = [UIColor.darkGray.cgColor, UIColor.blue.cgColor]
                layer.opacity = 1.0
                self.view.layer.insertSublayer(layer, at: 0)
            case .snow:
                layer.removeFromSuperlayer()
                weatherLabel.text = "Snowy"
                layer = CAGradientLayer()
                layer.frame = self.view.bounds
                layer.colors = [UIColor.gray.cgColor, UIColor.white.cgColor]
                layer.opacity = 1.0
                self.view.layer.insertSublayer(layer, at: 0)
            case .fog:
                layer.removeFromSuperlayer()
                weatherLabel.text = "Foggy"
                layer = CAGradientLayer()
                layer.frame = self.view.bounds
                layer.colors = [UIColor.darkGray.cgColor, UIColor.gray.cgColor]
                layer.opacity = 1.0
                self.view.layer.insertSublayer(layer, at: 0)
            case .sleet:
                layer.removeFromSuperlayer()
                weatherLabel.text = "Sleet"
                layer = CAGradientLayer()
                layer.frame = self.view.bounds
                layer.colors = [UIColor.darkGray.cgColor, UIColor.white.cgColor]
                layer.opacity = 1.0
                self.view.layer.insertSublayer(layer, at: 0)
            case .wind:
                layer.removeFromSuperlayer()
                weatherLabel.text = "Windy"
                layer = CAGradientLayer()
                layer.frame = self.view.bounds
                layer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
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

        
        setupDefaultUI()
        
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
    
    

