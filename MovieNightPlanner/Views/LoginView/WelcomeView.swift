//
//  WelcomeView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 5.07.2023.
//

import SwiftUI
import FirebaseAuth

struct WelcomeView: View {
    @Namespace var namespace
    
    @ObservedObject var userViewModel: UserViewModel
    
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
                
                if userViewModel.isShowingLoginTab {
                    LoginTabView(userViewModel: userViewModel, namespace: namespace)
                        .zIndex(1)
                } else {
                    SignUpTabView(userViewModel: userViewModel, namespace: namespace)
                        .zIndex(2)
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .onAppear {
                userViewModel.listenToAuthState()
            }
            .overlay {
                ZStack(alignment: .center) {
                    Color.clear
                        .background(.ultraThinMaterial)
                        .ignoresSafeArea()
                    
                    RoundedRectangle(cornerRadius: 60)
                        .fill(LinearGradient(colors: [Color(hex: "9C3FE4"), Color(hex: "C65647")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 200, height: 200)
                    
                    LottieView(lottieAnimation: .loading, playing: $userViewModel.loading)
                        .frame(width: 120, height: 120)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(userViewModel.loading ? 1 : 0)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(userViewModel: UserViewModel())
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 14")
            .previewDisplayName("iPhone 14")
            
        WelcomeView(userViewModel: UserViewModel())
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11")
            .previewDisplayName("iPhone 11")
        
        WelcomeView(userViewModel: UserViewModel())
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 8")
            .previewDisplayName("iPhone 8")
        
        WelcomeView(userViewModel: UserViewModel())
            .preferredColorScheme(.dark)
            .previewDevice("iPhone SE (3rd generation)")
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
