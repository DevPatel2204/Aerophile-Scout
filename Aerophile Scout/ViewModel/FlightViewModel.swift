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
    
    func getFlight(iata: String) {
        guard !iata.isEmpty else {
            print("⚠️ Empty flight number")
            errorMessage = "Please enter a flight number"
            showError = true
            return
        }
        
        loading = true
        //print("🔍 Fetching flight: \(iata)")
        
        flightservice.getFlight(iata: iata) { [weak self] flight in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.loading = false
                
                if let flight = flight, !flight.data.isEmpty {
                    //print("✅ Flight data received")
                    self.flight = flight
                    let flightData = flight.data[0]
                    
                    // Update status info
                    self.info = Info(
                        status: flightData.flight_status,
                        icon: "airplane",
                        color: .blue,
                        date: flightData.flight_date
                    )
                    //print("📊 Status updated: \(flightData.flight_status)")
                    
                    // Update departure info
                    self.departureInfo = DepartureInfo(
                        airport: flightData.departure.airport ?? "N/A",
                        terminal: flightData.departure.terminal ?? "N/A",
                        scheduled: flightData.departure.scheduled ?? "N/A",
                        actual: flightData.departure.actual ?? "N/A"
                    )
                    //print("🛫 Departure info updated")
                    
                    // Update arrival info
                    self.arrivalInfo = ArrivalInfo(
                        airport: flightData.arrival.airport ?? "N/A",
                        terminal: flightData.arrival.terminal ?? "N/A",
                        scheduled: flightData.arrival.scheduled ?? "N/A",
                        actual: flightData.arrival.actual ?? "N/A"
                    )
                    //print("🛬 Arrival info updated")
                    
                    // Update airline info
                    self.airlineInfo = AirlineInfo(
                        airline: flightData.airline.name,
                        flightNumber: flightData.flight.number,
                        flightSeries: flightData.flight.iata
                    )
                    //print("✈️ Airline info updated")
                    
                } else {
                    print("❌ No flight data found")
                    self.errorMessage = "No flight information found"
                    self.showError = true
                }
            }
        }
    }
    
    private func getStatusColor(_ status: String) -> Color {
        switch status.lowercased() {
        case "active": return .blue
        case "scheduled": return .green
        case "landed": return .gray
        case "cancelled": return .red
        default: return .orange
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
        let divide = hour!.split(separator: "T")
        let exactHour = divide[1].split(separator: "+")
        let hourString = String(exactHour[0])
        return hourString
    }
    
    var fixedDepartureActual : String{
           let hour = flight.data[0].departure.actual
        let divide = hour!.split(separator: "T")
           let exactHour = divide[1].split(separator: "+")
           let hourString = String(exactHour[0])
           return hourString
           
       }
       
       var fixedArrivalScheduled : String{
           let hour = flight.data[0].arrival.scheduled
           let divide = hour!.split(separator: "T")
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

