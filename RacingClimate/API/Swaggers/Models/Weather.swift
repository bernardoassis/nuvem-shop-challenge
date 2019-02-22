//
// Weather.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Weather: Codable {

    public var _id: Double?
    public var main: String?
    public var _description: String?
    public var icon: String?

    public init(_id: Double?, main: String?, _description: String?, icon: String?) {
        self._id = _id
        self.main = main
        self._description = _description
        self.icon = icon
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case main
        case _description = "description"
        case icon
    }


}
