//
//  Tabbar.swift
//  Aerophile Scout
//
//  Created by Dev on 28/12/24.
//

import SwiftUI

struct Tabbar: View {
    @State private var selectedOption: Int = 0
    var body: some View {
        TabView{
            Home_Screen(selectedOption: $selectedOption)
                .tabItem {
                    Label("Tracker", systemImage: "airplane.circle.fill")
                        .foregroundStyle(.black)
                }
            News_Screen()
                .tabItem{
                Label("News", systemImage: "newspaper.fill")
                    .foregroundStyle(.black)
            }
            Chat_Screen()
                .tabItem{
                    Label("Help",systemImage: "text.bubble.fill")
                        .foregroundStyle(.black)
                }
        }
    }
}

#Preview {
    Tabbar()
}
