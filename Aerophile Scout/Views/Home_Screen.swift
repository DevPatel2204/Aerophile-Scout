//
//  FlightViewModel.swift
//  Aerophile Scout
//
//  Created by Dev on 26/12/24.
//
import SwiftUI

struct Home_Screen: View {
    @State var Flight_No = ""
    @StateObject var FlightVM = FlightViewModel()
    @Binding var selectedOption: Int

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 32) {
                    // Title
                    Text("Aerophile Scout")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(colors: [.white, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    // Segmented Control
                    HStack(spacing: 0) {
                        segmentButton(title: "By Flight No", isSelected: selectedOption == 0) {
                            withAnimation(.spring(response: 0.3)) {
                                selectedOption = 0
                            }
                        }

                        segmentButton(title: "By Route", isSelected: selectedOption == 1) {
                            withAnimation(.spring(response: 0.3)) {
                                selectedOption = 1
                            }
                        }
                    }
                    .background(
                        Color.white.opacity(0.1)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                    
                    // Search TextField
                    TextField("Enter Flight Number", text: $Flight_No)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        .textFieldStyle(PlainTextFieldStyle())
                        .autocapitalization(.allCharacters)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                    
                    Spacer()
                    
                    // Search Button
                    Button {
                        // Add your search action here
                    } label: {
                        Text("Search")
                            .fontWeight(.medium)
                            .frame(width: 200, height: 50)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                    Spacer()
                }
                .padding(.top)
            }
        }
    }
    
    // Helper function for segment buttons
    private func segmentButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.medium)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.white : Color.clear)
                .foregroundStyle(isSelected ? .black : .white)
                .clipShape(Capsule())
                .shadow(color: isSelected ? .black.opacity(0.1) : .clear, radius: 4, x: 0, y: 2)
        }
        .animation(.spring(response: 0.3), value: isSelected)
    }
}

#Preview {
    Home_Screen(selectedOption: .constant(0))
}
