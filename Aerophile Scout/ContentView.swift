//
//  ContentView.swift
//  Aerophile Scout
//
//  Created by Dev on 01/10/24.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        if UserDefaults.standard.bool(forKey: "status") {
            Tabbar()
        } else {
            SplashScreen()
        }
    }
}

#Preview {
    ContentView()
}
