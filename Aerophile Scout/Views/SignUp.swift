//
//  SignUp.swift
//  Aerophile Scout
//
//  Created by Dev on 02/10/24.
//

import SwiftUI
import FirebaseAuth

struct SignUp: View {
    @State private var username : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                  .ignoresSafeArea()
                VStack{
                    VStack(spacing:5){
                        Text("Hey There! Avgeek!")
                            .foregroundStyle(.white)
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                        Text("Sign Up to continue")
                            .foregroundStyle(.white.opacity(0.8))
                            .font(.system(size: 20, design: .rounded))
                    }
                    .padding(.bottom, 40)
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 390, height: 60)
                        .background(Color.white.opacity(0.3))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                                                )
                        .padding(.horizontal,30)
                    
                    TextField("E-Mail", text: $email)
                        .padding()
                        .frame(width: 390, height: 60)
                        .background(Color.white.opacity(0.3))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                                                )
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 390, height: 60)
                        .background(Color.white.opacity(0.3))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                                                )
                        .padding()
                    
                    SecureField("confirmPassword", text: $confirmPassword)
                        .padding()
                        .frame(width: 390, height: 60)
                        .background(Color.white.opacity(0.3))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                                                )
                        .padding()
                    
                    Button {
                        authViewModel.signUp(email: email, password: password) { success in
                            if success {
                                print("User Created")
                            } else {
                                print(authViewModel.errorMessage ?? "Error")
                            }
                        }
                    } label: {
                        Text("SignUp")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                                       .foregroundColor(.white)
                                                       .frame(width: 200, height: 20)
                                                       .padding()
                                                       .background(Color.blue.opacity(0.8))
                                                       .cornerRadius(15)
                                                       .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    }
                    
                    HStack(spacing: 1) {
                        Text("Already have an account?")
                            .foregroundStyle(.black)
                            .font(.footnote)
                            .padding()
                        
                        NavigationLink(destination: SignIn()) {
                            Text("Login")
                                .foregroundStyle(.black)
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    SignUp()
}

