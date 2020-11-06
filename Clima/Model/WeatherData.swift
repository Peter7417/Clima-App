//
//  WeatherData.swift
//  Clima
//
//  Created by Partheepan Shiyamsunthar on 10/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name:String
    let main:Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
    let pressure: Int
}

struct Weather:Codable{
    let id:Int
    let main: String
    let description: String
}
