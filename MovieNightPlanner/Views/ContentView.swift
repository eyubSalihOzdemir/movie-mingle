//
//  ContentView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 1.07.2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject var loginViewModel = LoginViewModel()
    
    @State private var isActive = false
    
    var body: some View {
        Group {
            if loginViewModel.user != nil {
                Fooview(loginViewModel: loginViewModel)
            } else {
                WelcomeView(loginViewModel: loginViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
