//
//  AuthLogic.swift
//  Aerophile Scout
//
//  Created by Dev on 23/12/24.
//

import Foundation
import FirebaseAuth
class AuthViewModel:ObservableObject{
    @Published var User:User? = nil
    @Published var errorMessage:String? = nil
    
    init() {
        self.User = Auth.auth().currentUser
    }
    
    func signUp(email:String,password:String,completion:@escaping (Bool)->Void){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error{
                self.errorMessage = error.localizedDescription
                completion(false)
            }else{
                self.User = result?.user
                completion(true)
            }
        }
        
    }
    func signIn(email:String,password:String,completion:@escaping (Bool)->Void){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                self.errorMessage = error.localizedDescription
                completion(false)
            }else{
                self.User = result?.user
                completion(true)
            }
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.User = nil
        }catch{
            self.errorMessage = error.localizedDescription
        }
    }
}
