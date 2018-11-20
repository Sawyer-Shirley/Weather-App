//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Sawyer Shirley on 11/16/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let apiManager = APIManager()
    
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    
    func getGeocodingData(searchAddress: String) {
        apiManager.geocode(address: searchAddress) {
            (geocodingData, error) in
            if let receivedError = error {
                print(receivedError.localizedDescription)
                self.handleError()
                return
            }
            
            if let recievedData = geocodingData {
                self.geocodingData = recievedData
                retriveWeatherData(latitude: recievedData.latitude, longitude: recievedData.longitude)
            } else {
                self.handleError()
                return
            }
        }
        
        func retriveWeatherData(latitude: Double, longitude: Double) {
            APIManager.getWeather(for: (Location(latitude, longitude))) { (weatherData, error)
                in
                if let receivedError = error {
                    print(receivedError.localizedDescription)
                    self.handleError()
                    return
                }
                if let receivedData = weatherData {
                    self.weatherData = receivedData
                    if let parent = self.parent as? PageViewController {
                        if let otherViewController = parent.pageViewController(parent, viewControllerBefore: self) as? ViewController {
                            otherViewController.displayGeocodingData = self.geocodingData
                            otherViewController.displayWeatherData = self.weatherData
                            parent.setViewControllers([otherViewController], direction: .reverse, animated: true, completion: nil)
                        }
                    }
                } else {
                    self.handleError()
                    return
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        getGeocodingData(searchAddress: searchAddress)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ViewController,
            let receivedGeocodingData = geocodingData,
            let retrievedWeatherData = weatherData {
            destinationVC.displayWeatherData = retrievedWeatherData
            destinationVC.displayGeocodingData = receivedGeocodingData
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }
}
