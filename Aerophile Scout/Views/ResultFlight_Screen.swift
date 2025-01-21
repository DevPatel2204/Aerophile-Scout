//
//  ResultFlight_Screen.swift
//  Aerophile Scout
//
//  Created by Dev on 13/01/25.
//

import SwiftUI

struct ResultFlight_Screen: View {
    @StateObject var FlightVM = FlightViewModel()
    var flight: String
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            if FlightVM.loading {
                ProgressView("Loading Flight Details...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        statusCard
                        Group {
                            departureCard
                            arrivalCard
                            airlineCard
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationTitle("Flight Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            FlightVM.getFlight(iata: flight)
        }
        .alert("Error", isPresented: $FlightVM.showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(FlightVM.errorMessage)
        }
    }
    
    // MARK: - Status Card
    private var statusCard: some View {
        VStack(spacing: 12) {
            HStack {
                Text(FlightVM.info.status.firstUppercased)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Image(systemName: FlightVM.getIcon.0)
                    .foregroundColor(FlightVM.getIcon.1)
                    .font(.title)
            }
            
            Text(formatDate(FlightVM.info.date))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 5)
        )
        .padding(.horizontal)
    }
    
    // MARK: - Departure Card
    private var departureCard: some View {
        FlightInfoCard(
            title: "Departure",
            airport: FlightVM.departureInfo.airport,
            terminal: FlightVM.departureInfo.terminal,
            scheduled: formatTime(FlightVM.departureInfo.scheduled),
            actual: formatTime(FlightVM.departureInfo.actual),
            systemImage: "airplane.departure"
        )
    }
    
    // MARK: - Arrival Card
    private var arrivalCard: some View {
        FlightInfoCard(
            title: "Arrival",
            airport: FlightVM.arrivalInfo.airport,
            terminal: FlightVM.arrivalInfo.terminal,
            scheduled: formatTime(FlightVM.arrivalInfo.scheduled),
            actual: formatTime(FlightVM.arrivalInfo.actual),
            systemImage: "airplane.arrival"
        )
    }
    
    // MARK: - Airline Card
    private var airlineCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "airplane.circle.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                Text("Airline Information")
                    .font(.headline)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                InfoRow(title: "Airline", value: FlightVM.airlineInfo.airline)
                InfoRow(title: "Flight", value: FlightVM.airlineInfo.flightNumber)
                InfoRow(title: "Flight Code", value: FlightVM.airlineInfo.flightSeries)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 5)
        )
    }
    
    // MARK: - Helper Functions
    private func formatDate(_ dateString: String) -> String {
        // Add date formatting logic here
        return dateString
    }
    
    private func formatTime(_ timeString: String) -> String {
        // Add time formatting logic here
        return timeString
    }
}

// MARK: - Supporting Views
struct FlightInfoCard: View {
    let title: String
    let airport: String
    let terminal: String
    let scheduled: String
    let actual: String
    let systemImage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: systemImage)
                    .font(.title2)
                    .foregroundColor(.blue)
                Text(title)
                    .font(.headline)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                InfoRow(title: "Airport", value: airport)
                InfoRow(title: "Terminal", value: terminal)
                InfoRow(title: "Scheduled", value: scheduled)
                InfoRow(title: "Actual", value: actual)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 5)
        )
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    NavigationView {
        ResultFlight_Screen(flight: "BA123")
    }
}
