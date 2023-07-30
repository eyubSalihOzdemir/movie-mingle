//
//  ContentView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 1.07.2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        Group {
            if userViewModel.authUser != nil {
                TabView(userViewModel: userViewModel)
            } else {
                WelcomeView(userViewModel: userViewModel)
            }
        }
        .onAppear {
            userViewModel.listenToAuthState()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
