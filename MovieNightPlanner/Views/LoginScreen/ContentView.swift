//
//  ContentView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 1.07.2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @Namespace var namespace
    
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                LinearGradient(colors: [Color.orange, Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                GeometryReader { geometry in
                    AutoScrollBackgroundView()
                        .opacity(0.75)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .scaleEffect(1.1)
                }
                .ignoresSafeArea()
                
                if loginViewModel.isShowingLoginTab {
                    LoginTabView(loginViewModel: loginViewModel, namespace: namespace)
                        .zIndex(1)
                } else {
                    SignUpTabView(loginViewModel: loginViewModel, namespace: namespace)
                        .zIndex(2)
                }
                
                /// To push a view programatically
                NavigationLink(destination: Fooview(), isActive: $loginViewModel.signedIn) {
                    Text("testsetsetset")
                }.hidden()
            }
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        print("User signed in!")
                        // navigate to other screen with user information
                        
                    } else {
                        //print("User is NOT signed in!")
                        //
                    }
                }
            }
            .overlay {
                ZStack(alignment: .center) {
                    Color.clear
                        .background(.ultraThinMaterial)
                        .ignoresSafeArea()
                    
                    RoundedRectangle(cornerRadius: 60)
                        .fill(LinearGradient(colors: [Color(hex: "9C3FE4"), Color(hex: "C65647")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 200, height: 200)
                    
                    LottieView(name: "loading_alternate", playing: $loginViewModel.loading)
                        .frame(width: 120, height: 120)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(loginViewModel.loading ? 1 : 0)
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 14")
            .previewDisplayName("iPhone 14")
            
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11")
            .previewDisplayName("iPhone 11")
        
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 8")
            .previewDisplayName("iPhone 8")
        
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone SE (3rd generation)")
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
