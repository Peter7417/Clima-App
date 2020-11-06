//
//  WeatherModel.swift
//  Clima
//
//  Created by Partheepan Shiyamsunthar on 10/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditionID: Int
    let CityName: String
    let temperature: Double
    
    var temperatureString:String{
        return String(format: "%.1f", (temperature))
    }
    
    var conditionName: String {
        switch conditionID {
        case 200,201,202,230,231,232:
            return "cloud.bolt.rain"
        case 210,211,212,221:
            return "cloud.bolt"
        case 300,301,302,310,311,312,313,314,321:
            return "cloud.drizzle"
        case 500,501,520:
            return "cloud.rain"
        case 502,503,504,511,522,531:
            return "cloud.heavyrain"
        case 600,601,615,616,620,621,622:
            return "cloud.snow"
        case 602:
            return "Snow"
        case 611,612,613:
            return "cloud.sleet"
        case 701,721:
            return "sun.haze"
        case 711:
            return "smoke"
        case 731,751,761,762,771:
            return "wind"
        case 741:
            return "cloud.fog"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
    
}
