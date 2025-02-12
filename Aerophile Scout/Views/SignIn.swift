//
//  LoginScreen.swift
//  Aerophile Scout
//
//  Created by Dev on 02/10/24.
//

import SwiftUI

struct SignIn: View {
    @State private var email :String = ""
    @State private var password :String = ""
    @State private var isLoggedIn :Bool = false
    @StateObject private var authViewModel = AuthViewModel()
    var body: some View {
        NavigationStack {
            if isLoggedIn {
                Tabbar()
            }else{
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .ignoresSafeArea()
                        VStack(spacing: 20) {
                            VStack(spacing:5){
                                Text("Welcome Back")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40, weight: .bold, design: .rounded))
                                Text("Sign in to continue")
                                    .foregroundStyle(.white.opacity(0.8))
                                    .font(.system(size: 20, design: .rounded))
                            }
                            .padding(.bottom, 40)
                            
                            TextField("Email", text: $email)
                                .padding()
                                .frame(width: 370, height: 50)
                                .background(Color.white.opacity(0.3))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white.opacity(0.4), lineWidth: 2)
                                )
                                .padding(.horizontal,30)
                            
                            SecureField("Password", text: $password)
                                .padding()
                                .frame(width: 370, height: 50)
                                .background(Color.white.opacity(0.3)
                                    .foregroundStyle(.white))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white.opacity(0.4), lineWidth: 2)
                                )
                                .padding()
                            
                            Button {
                                authViewModel.signIn(email: email, password: password) { success in
                                    if success {
                                        print("User Signed in successfully")
                                        isLoggedIn = true
                                    } else {
                                        print(authViewModel.errorMessage ?? "Error")
                                    }
                                }
                            } label: {
                                Text("LogIn")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .frame(width: 200, height: 20)
                                    .padding()
                                    .background(Color.blue.opacity(0.8))
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 10)
                            
                            HStack(spacing: 1) {
                                Text("Don't have an account?")
                                    .foregroundStyle(.black)
                                    .font(.footnote)
                                    .padding()
                                
                                NavigationLink(destination: SignUp()) {
                                    Text("SignUp")
                                        .foregroundStyle(.black)
                                }
                            }
                            
                        }
                        .navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
    }


#Preview {
    SignIn()
}
