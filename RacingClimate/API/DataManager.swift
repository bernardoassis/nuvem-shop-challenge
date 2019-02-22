//
//  DataManager.swift
//  RacingClimate
//
//  Created by Bernardo Carvalho on 19/02/19.
//  Copyright © 2019 Bernardo Carvalho. All rights reserved.
//

import Foundation

class DataManager {
    
    static let cities : [String : String] = ["Silverstone, UK" : "2637827", "São Paulo, Brazil" : "3448439", "Melbourne, Australia" : "2158177", "Monte Carlo, Monaco" : "3905658"]
    
    static let APPID = "2cebe458561b8e39965d632395a2852e"
    static let UNITS = "imperial"
    
    static let shared : DataManager = DataManager()
    
    init() {
    }
    
    // Load current and forecast weather data and save in the app cache.
    
    func loadCitiesWeatherData(_ completion: @escaping ((_ data: [String : Info], _ error: Error?) -> Void)) {
        
        let requestGroup = DispatchGroup()
        var infos = [String : Info]()
        var reqError : Error? = nil
        
        for city in DataManager.cities.keys {
            requestGroup.enter()
            requestGroup.enter()
            
            loadCurrentWeatherData(city) { (info, error) in
                if (error == nil) {
                    infos[city] = info
                } else {
                    reqError = error
                }
                
                requestGroup.leave()
            }
            
            loadForecastWeatherData(city) { (info, error) in
                requestGroup.leave()
            }
        }
        
        requestGroup.notify(queue: DispatchQueue.main, execute: {
            completion(infos, reqError)
        })
    }
    
    // Try to load the forecast weather from the Cache. If it's not available, fetch the data from the API.
    
    func loadCityForecastWeatherData(_ city: String, completion: @escaping ((_ data: Forecast?, _ error: Error?) -> Void)) {
        
        let cityId = DataManager.cities[city]
        
        if let cache = CacheManager.shared.retrieveForecast(key: cityId!) {
            completion(cache, nil)
        } else {
            DataManager.shared.loadForecastWeatherData(city) { (forecastWeather, error) in
                if (error != nil) {
                    completion(nil, error)
                } else {
                    completion(forecastWeather, error)
                }
            }
            
        }
    }
    
    // Private methods
    
    // Load the current weather data from the API and save it on the app cache. If it's not available, try to fetch the information from the Cache.
    
    fileprivate func loadCurrentWeatherData(_ city: String, completion: @escaping ((_ data: Info?, _ error: Error?) -> Void)) {
        
        let cityId = DataManager.cities[city]
        
        WeatherAPI.currentWeatherByCity(_id: cityId!, units: DataManager.UNITS, APPID: DataManager.APPID) { (info, error) in
            if (error != nil) {
                if let cache = CacheManager.shared.retrieveInfo(key: cityId!) {
                    completion(cache, nil)
                } else {
                    completion(nil, error)
                }
            } else {
                CacheManager.shared.save(key: cityId!, info: info!)
                completion(info, error)
            }
        }
    }
    
    // Load the forecast weather data from the API and save it on the app cache. If it's not available, try to fetch the information from the Cache.
    
    fileprivate func loadForecastWeatherData(_ city: String, completion: @escaping ((_ data: Forecast?, _ error: Error?) -> Void)) {
        
        let cityId = DataManager.cities[city]

        WeatherAPI.forecastWeatherByCity(_id: cityId!, units: DataManager.UNITS, APPID: DataManager.APPID) { (forecastWeather, error) in
            if (error != nil) {
                if let cache = CacheManager.shared.retrieveForecast(key: cityId!) {
                    completion(cache, nil)
                } else {
                    completion(nil, error)
                }
            } else {
                CacheManager.shared.save(key: cityId!, forecast: forecastWeather!)
                completion(forecastWeather, error)
            }
        }
    }
    
}
