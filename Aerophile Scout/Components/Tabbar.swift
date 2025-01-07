//
//  Tabbar.swift
//  Aerophile Scout
//
//  Created by Dev on 28/12/24.
//

import SwiftUI

struct Tabbar: View {
    var body: some View {
        TabView{
            Home_Screen()
                .tabItem {
                    Label("Tracker", systemImage: "airplane.circle.fill")
                        .foregroundStyle(.black)
                }
            News_View()
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
