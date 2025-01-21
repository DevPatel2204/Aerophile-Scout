//
//  FlightViewModel.swift
//  Aerophile Scout
//
//  Created by Dev on 26/12/24.
//

import Foundation
import SwiftUI

class FlightViewModel : ObservableObject {
    private var flightservice = FlightService()
    
    var flight = FlightDetailModel(data: [])
    
    @Published var info = Info(status: "", icon: "", color: .gray, date: "")
    @Published var departureInfo = DepartureInfo(airport: "", terminal: "", scheduled: "", actual: "")
    @Published var arrivalInfo = ArrivalInfo(airport: "", terminal: "", scheduled: "", actual: "")
    @Published var airlineInfo = AirlineInfo(airline: "", flightNumber: "", flightSeries: "")
    @Published var loading : Bool = false
    @Published var showError = false
    @Published var errorMessage = ""
    
    func getFlight(iata : String) {
        guard !iata.isEmpty else {
            errorMessage = "Please enter a flight number"
            showError = true
            return
        }
        
        loading = true
        flightservice.getFlight(iata: iata) { [weak self] flight in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.loading = false
                
                if let flight = flight, !flight.data.isEmpty {
                    self.flight = flight
                    self.info = Info(status: flight.data[0].flight_status, icon: "airplane", color: .blue, date: flight.data[0].departure.scheduled)
                    self.departureInfo = DepartureInfo(airport: flight.data[0].departure.airport, terminal: flight.data[0].departure.terminal, scheduled: flight.data[0].departure.scheduled, actual: flight.data[0].departure.actual)
                    self.arrivalInfo = ArrivalInfo(airport: flight.data[0].arrival.airport, terminal: flight.data[0].arrival.terminal, scheduled: flight.data[0].arrival.scheduled, actual: flight.data[0].arrival.actual)
                    self.airlineInfo = AirlineInfo(airline: flight.data[0].airline.name, flightNumber: flight.data[0].flight.number, flightSeries: flight.data[0].flight.iata)
                } else {
                    self.errorMessage = "No flight information found"
                    self.showError = true
                }
            }
        }
    }
    
    var date : String{
        let date = flight.data[0].flight_date
        let divide = date.split(separator: "-")
        let reverse = divide.reversed()
        return reverse.joined(separator: "-")
        
    }
    var fligthNumber : String{
        return flight.data[0].flight.iata
    }
    
    var fixedDeparture : String{
        let hour = flight.data[0].departure.scheduled
        let divide = hour.split(separator: "T")
        let exactHour = divide[1].split(separator: "+")
        let hourString = String(exactHour[0])
        return hourString
    }
    
    var fixedDepartureActual : String{
           let hour = flight.data[0].departure.actual
           let divide = hour.split(separator: "T")
           let exactHour = divide[1].split(separator: "+")
           let hourString = String(exactHour[0])
           return hourString
           
       }
       
       var fixedArrivalScheduled : String{
           let hour = flight.data[0].arrival.scheduled
           let divide = hour.split(separator: "T")
           let exactHour = divide[1].split(separator: "+")
           let hourString = String(exactHour[0])
           return hourString
       }
       
       var fixedArrivalActual : String{
           if let hour = flight.data.first?.arrival.actual{
               let divide = hour.split(separator: "T")
               let exactHour = divide[1].split(separator: "+")
               let hourString = String(exactHour[0])
               return hourString
           } else {
               return "-"
           }
       }
       
       var getIcon: (String, Color) {
           guard !flight.data.isEmpty else {
               return ("airplane.circle.fill", Color.gray) // Default state when no flight data
           }
           
           switch flight.data[0].flight_status {
           case "scheduled": return ("calendar.circle.fill", Color.yellow)
           case "active": return ("airplane.circle.fill", Color.blue)
           case "landed": return ("checkmark.circle.fill", Color.green)
           case "cancelled": return ("xmark.circle.fill", Color.red)
           case "incident": return ("exclamationmark.circle.fill", Color.orange)
           case "diverted": return ("arrow.up.arrow.down.circle.fill", Color.orange)
           default:
               return ("airplane.circle.fill", Color.blue)
           }
       }
       
       
   }

   extension StringProtocol {
       var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
   }

