//
//  LoginViewModel.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 4.07.2023.
//

import Foundation

@MainActor class LoginViewModel: ObservableObject {
    @Published var isShowingLoginTab = true
    
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    
    init() {
        print("LoginViewModel initialized.")
    }
    
    func signIn() {
        // 
    }
    
    func signUp() {
        //
    }
    
    func forgotPassword() {
        //
    }
}
