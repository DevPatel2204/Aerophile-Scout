//
//  Information_Flight.swift
//  Aerophile Scout
//
//  Created by Dev on 24/12/24.
//

import Foundation
import SwiftUICore

struct Info{
    var status : String
    var icon : String
    var color : Color
    var date : String
}


struct DepartureInfo {
    var airport : String
    var terminal : String
    var scheduled : String
    var actual : String
}

struct ArrivalInfo{
    var airport : String
    var terminal : String
    var scheduled : String
    var actual : String
}

struct AirlineInfo{
    var airline : String
    var flightNumber : String
    var flightSeries : String
}
