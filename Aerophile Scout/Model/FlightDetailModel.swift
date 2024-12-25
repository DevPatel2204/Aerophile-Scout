//
//  FlightDetailModel.swift
//  Aerophile Scout
//
//  Created by Dev on 03/10/24.
//

import Foundation

struct FlightDetailModel:Codable {
    var data : [Data]
}

struct Data:Codable {
    var flight_date:String
    var flight_status:String
    var departure:Departure
    var arrival:Arrival
    var airline:Airline
    var flight:Flight
    var aircraft:Aircraft
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




