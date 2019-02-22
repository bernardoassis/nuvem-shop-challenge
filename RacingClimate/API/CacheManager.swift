//
//  CacheManager.swift
//  RacingClimate
//
//  Created by Bernardo Carvalho on 22/02/19.
//  Copyright © 2019 Bernardo Carvalho. All rights reserved.
//

import Foundation

class CacheManager {
    fileprivate let userDefaults = UserDefaults.standard
    
    static let shared : CacheManager = CacheManager()
    
    init() {        
    }
    
    func save(key: String, info : Info) {
        if let data: Data = try? JSONEncoder().encode(info) {
            userDefaults.set(data, forKey: "info_\(key)")
            userDefaults.synchronize()
        }
    }
    
    func retrieveInfo(key: String) -> Info? {
        if let data = userDefaults.data(forKey: "info_\(key)") {
            return try? JSONDecoder().decode(Info.self, from: data)
        }
        
        return nil
    }
    
    func save(key: String, forecast : Forecast) {
        if let data: Data = try? JSONEncoder().encode(forecast) {
            userDefaults.set(data, forKey: "forecast_\(key)")
            userDefaults.synchronize()
        }
    }
    
    func retrieveForecast(key: String) -> Forecast? {
        if let data = userDefaults.data(forKey: "forecast_\(key)") {
            return try? JSONDecoder().decode(Forecast.self, from: data)
        }
        
        return nil
    }

}
