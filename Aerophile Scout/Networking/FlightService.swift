//
//  FlightService.swift
//  Aerophile Scout
//
//  Created by Dev on 03/10/24.
//

import Foundation
import SwiftUI


class FlightService{
    
    private var apiKey : String? {
        guard let path = Bundle.main.path(forResource: "API_KEY", ofType: "plist") ,
              let plist = NSDictionary(contentsOfFile: path),
              let key = plist["Aviation_API_KEY"] as? String else {
            print("Error: API key not found in api.plist")
            return nil
        }
        return key
    }
    
    func getFlight(iata : String, completion: @escaping(FlightDetailModel?) -> ())
    {
        guard let apiKey = apiKey else {
            print("Error: API key not found")
            completion(nil)
            return
        }
        
        let urlString = "https://api.aviationstack.com/v1/flights?access_key=\(apiKey)&flight_iata=\(iata)"
        print("Requesting URL: \(urlString)") // Debug print
        
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Add required headers
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Invalid response type")
                completion(nil)
                return
            }
            
            print("HTTP Status Code: \(httpResponse.statusCode)")
            
            switch httpResponse.statusCode {
            case 200:
                guard let data = data else {
                    print("Error: No data received")
                    completion(nil)
                    return
                }
                
                // Debug print raw response
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw API Response: \(jsonString)")
                }
                
                do {
                    let flightData = try JSONDecoder().decode(FlightDetailModel.self, from: data)
                    print("Successfully decoded flight data with \(flightData.data.count) flights")
                    completion(flightData)
                } catch {
                    print("Decoding error: \(error)")
                    completion(nil)
                }
                
            case 401:
                print("Error: Unauthorized - Invalid API key")
                completion(nil)
            case 404:
                print("Error: Flight not found")
                completion(nil)
            case 429:
                print("Error: Rate limit exceeded")
                completion(nil)
            default:
                print("Error: Unexpected status code \(httpResponse.statusCode)")
                completion(nil)
            }
        }.resume()
    }
    
}

