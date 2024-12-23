//
//  LoginScreen.swift
//  Aerophile Scout
//
//  Created by Dev on 02/10/24.
//

import SwiftUI

struct SignIn: View {
    @State private var username :String = ""
    @State private var password :String = ""
    @State private var isLoggedIn :Bool = false
    @StateObject private var authViewModel = AuthViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 112/255, green: 215/255, blue: 255/255)
                    .ignoresSafeArea()
                VStack(spacing:5){
                    Text("Login")
                        .foregroundStyle(.black)
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 390, height: 60)
                        .background(Color.white.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 390, height: 60)
                        .background(Color.white.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                    
                    Button {
                        authViewModel.signIn(email: username, password: password) { success in
                            if success {
                                print("User Signed in successfully")
                                isLoggedIn = true // Move this inside the closure
                            } else {
                                print(authViewModel.errorMessage ?? "Error")
                            }
                        }
                    } label: {
                        Text("LogIn")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                            .frame(width: 200, height: 50)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
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

#Preview {
    SignIn()
}
