import SwiftUI

struct Home_Screen: View {
    @State private var Flight_No = ""
    @StateObject var FlightVM = FlightViewModel() // Use @StateObject to track changes in the ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                // Flight Number Input
                HStack {
                    Text("Flight No")
                        .font(.title)
                        .bold()
                        .padding(.leading, 10)
                    TextField("Enter Flight No", text: $Flight_No)
                        .padding(.horizontal, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing, 10)
                }
                
                // Search Button
                Button(action: {
                    FlightVM.getFlight(iata: Flight_No)
                }, label: {
                    Text("Search")
                        .font(.title)
                        .bold()
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                .padding(.top, 20)
                
                // Loading Indicator
                if FlightVM.loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                }
                
                // Display Flight Information
                if !FlightVM.info.status.isEmpty {
                    VStack {
                        Text("Flight Information")
                            .font(.title)
                            .bold()
                            .padding()
                        
                        HStack {
                            Text("Flight Status")
                                .font(.title2)
                                .bold()
                            Text(FlightVM.info.status)
                                .font(.title2)
                        }
                        .padding()
                        
                        HStack {
                            Text("Departure")
                                .font(.title2)
                                .bold()
                            Text(FlightVM.fixedDeparture)
                                .font(.title2)
                        }
                        .padding()
                        
                        HStack {
                            Text("Arrival")
                                .font(.title2)
                                .bold()
                            Text(FlightVM.fixedArrivalScheduled)
                                .font(.title2)
                        }
                        .padding()
                        
                        HStack {
                            Text("Airline")
                                .font(.title2)
                                .bold()
                            Text(FlightVM.airlineInfo.airline)
                                .font(.title2)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    Home_Screen()
}
