//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self
        
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    
    
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else{
            textField.placeholder = "Type a City Name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(city)
        }
        searchTextField.text = ""
        textField.placeholder = "Search"
    }
    
}


//MARK: - WeatherMangerDelegate


extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather (_ weatherManger: WeatherManager ,_ weather: WeatherModel){
        self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        self.cityLabel.text = weather.CityName
        self.temperatureLabel.text = weather.temperatureString
        
    }
    
    func didFailWithError(_ error: Error) {
        print (error)
    }
    
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManger.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManger.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchLocation(lat, lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
    }
}
