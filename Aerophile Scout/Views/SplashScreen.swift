//
//  SplashScreen.swift
//  Aerophile Scout
//
//  Created by Dev on 02/10/24.
//

import SwiftUI

struct SplashScreen: View {
    @State var splashshown: Bool = false
    var body: some View {
        NavigationStack {
            ZStack{
                Color(red: 112/255, green: 215/255, blue: 255/255)
                VStack{
                    Text("Track Your Flights")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    NavigationLink(destination: SignUp()){
                        Text("Let's Track")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .frame(width: 300,height: 50)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                    
                }
            }
            
            
            
            .ignoresSafeArea() // Background ignores safe area
        }
    }
}

#Preview {
    SplashScreen()
}
