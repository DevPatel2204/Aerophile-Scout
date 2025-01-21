//
//  FlightDetailModel.swift
//  Aerophile Scout
//
//  Created by Dev on 03/10/24.
//

import Foundation

struct FlightDetailModel: Codable {
    var pagination: Pagination?
    var data: [FlightData]
}

struct Pagination: Codable {
    var limit: Int
    var offset: Int
    var count: Int
    var total: Int
}

struct FlightData: Codable {
    var flight_date: String
    var flight_status: String
    var departure: Departure
    var arrival: Arrival
    var airline: Airline
    var flight: Flight
    var aircraft: Aircraft?
    
    enum CodingKeys: String, CodingKey {
        case flight_date
        case flight_status
        case departure
        case arrival
        case airline
        case flight
        case aircraft
    }
}

struct Departure :Codable{
    var airport:String
    var terminal:String
    var scheduled:String
    var actual:String
    var gate:String
}

struct Arrival :Codable{
    var airport:String
    var terminal:String
    var scheduled:String
    var actual:String
    var gate:String
}

struct Airline:Codable{
    var name :String
    var production_line:String
    var iata_type:String
    var model_name:String
}

struct Flight:Codable{
    var number :String
    var iata :String
    var icao :String
}

struct Aircraft:Codable{
    var registration :String
    var iata :String
    var icao :String
}


