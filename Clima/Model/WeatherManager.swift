//
//  WeatherManager.swift
//  Clima
//
//  Created by Partheepan Shiyamsunthar on 10/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManger: WeatherManager ,_ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    let weatherURL = apiKey().key()
    
    func fetchWeather (_ cityName:String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    
    func fetchLocation (_ latitude:Double, _ longitude:Double){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString)
    }
    
    var delegate: WeatherManagerDelegate?
    
    func performRequest(_ urlString:String){
        if let url = URL (string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    DispatchQueue.main.async{
                        if let weather = self.parseJSON(safeData){
                            self.delegate?.didUpdateWeather(self,weather)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionID: id, CityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    
    
    
}
