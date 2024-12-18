//
//  SignUp.swift
//  Aerophile Scout
//
//  Created by Dev on 02/10/24.
//

import SwiftUI

struct SignUp: View {
    @State private var username : String = ""
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color(red: 112/255, green: 215/255, blue: 255/255)
                    .ignoresSafeArea()
                VStack(spacing:5){
                    Text("SignUp")
                        .foregroundStyle(.black)
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 390, height: 60)
                        .background(Color.white.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                    
                    TextField("E-Mail", text: $email)
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
                    
                    SecureField("confirmPassword", text: $confirmPassword)
                        .padding()
                        .frame(width: 390, height: 60)
                        .background(Color.white.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                    
                    Button {
                        //Auth Code for SignUp from firebase
                        
                    } label: {
                        Text("SignUp")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                            .frame(width: 200 , height: 50)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    HStack(spacing:1){
                        Text(" Already have an account?")
                            .foregroundStyle(.black)
                            .font(.footnote)
                            .padding()
                        
                        
                        NavigationLink(destination:LoginScreen()){
                            Text("Login")
                                .foregroundStyle(.black)
                        }
                    }
                    
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

#Preview {
    SignUp()
}

