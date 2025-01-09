import SwiftUI
import GoogleGenerativeAI

struct Chat_Screen: View {
    
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    
    @State private var userPrompt = ""
    @State private var response = "Which Plane you are excited about?"
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Title
            Text("Hey Avggeek!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 40)
            
            // Response Area with ScrollView
            ZStack {
                ScrollView {
                    Text(cleanResponse(response))
                        .font(.title2)
                        .foregroundColor(.white) // White text for contrast
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.green) // Dark background for response
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 4)
                        .padding(.horizontal)
                }
                
                // Loading Indicatorbra
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .padding(.top, 30)
                }
            }
            
            // Input and Submit Section
            HStack(spacing: 15) {
                
                // TextField for User Input
                TextField("Ask anything...", text: $userPrompt)
                    .font(.title3)
                    .padding(15)
                    .background(Color.white , in: Capsule())
                    .foregroundColor(.black)
                    .disableAutocorrection(true)
                    .lineLimit(5)
                    .onSubmit {
                        generateResponse()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.indigo.opacity(0.7), lineWidth: 1)
                    )
                
                // Paper Plane Button
                Button(action: {
                    generateResponse()
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.blue))
                        .shadow(radius: 5)
                }
                .disabled(userPrompt.isEmpty)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .padding()
     /*   .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.7)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))*/ // Dark Gradient Background
        .background(.black)
    }
    
    // Clean the Response Text
    func cleanResponse(_ response: String) -> String {
        let cleanedResponse = response.replacingOccurrences(of: "*", with: "") // Remove any unwanted symbols
        return cleanedResponse
    }
    
    // Function to generate a response
    func generateResponse() {
        isLoading = true
        response = ""
        
        Task {
            do {
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = result.text ?? "No response Found"
                userPrompt = ""
            } catch {
                response = "Something went wrong: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
}

#Preview {
    Chat_Screen()
}
