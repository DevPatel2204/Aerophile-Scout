//
//  Gemini_API.swift
//  Aerophile Scout
//
//  Created by Dev on 07/01/25.
//

import Foundation

enum APIKey {
    
    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "API_KEY", ofType: "plist")
        else {
            fatalError("Couldn't find file 'API_KEY.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "GeminiAPI_KEY") as? String else {
            fatalError("Couldn't find key 'GeminiAPI_KEY' in 'API_KEY.plist'.")
        }
        if value.starts(with: "_") {
            fatalError(
                "Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key."
            )
        }
        return value
    }
}



