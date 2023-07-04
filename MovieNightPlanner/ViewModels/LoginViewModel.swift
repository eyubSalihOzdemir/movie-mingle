//
//  LoginViewModel.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 4.07.2023.
//

import Foundation
import FirebaseAuth

@MainActor class LoginViewModel: ObservableObject {
    @Published var loading = false
    
    @Published var isShowingLoginTab = true
    
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    
    init() {
        print("LoginViewModel initialized.")
    }
    
    func signIn() {
        loading = true
        
        Auth.auth().signIn(withEmail: "test123@gmail.com", password: "test123") { [weak self] authResult, error in
            guard self != nil else { return }
            
            if authResult != nil {
                print("Successfully signed in!")
                //
            }
            
            if let error = error {
                print("There was an error during login!")
                print(error.localizedDescription)
            }
        }
        
        loading = false
    }
    
    func signUp() {
        loading = true
        
        print("SingUp function fired!")
        
        Auth.auth().createUser(withEmail: "test12345@gmail.com", password: "test12345") { authResult, error in
            if authResult != nil {
                print("Successfully signed up!")
                //
            }
            
            if let error = error {
                print("There was an error during sign up!")
                print(error.localizedDescription)
            }
        }
        
        loading = false
    }
    
    func forgotPassword() {
        //
    }
    
    func signOut() {
        do {
          try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
