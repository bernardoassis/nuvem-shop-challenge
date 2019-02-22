//
// Main.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Main: Codable {

    public var temp: Double?
    public var pressure: Double?
    public var humidity: Int?
    public var tempMin: Double?
    public var tempMax: Double?

    public init(temp: Double?, pressure: Double?, humidity: Int?, tempMin: Double?, tempMax: Double?) {
        self.temp = temp
        self.pressure = pressure
        self.humidity = humidity
        self.tempMin = tempMin
        self.tempMax = tempMax
    }

    public enum CodingKeys: String, CodingKey { 
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }


}
