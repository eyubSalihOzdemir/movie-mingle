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
    
    @State private var isShowingLoginTab = true
    
    var body: some View {
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
            
            if isShowingLoginTab {
                LoginTabView(isShowingLoginTab: $isShowingLoginTab, namespace: namespace)
                    .zIndex(1)
            } else {
                SignUpTabView(isShowingLoginTab: $isShowingLoginTab, namespace: namespace)
                    .zIndex(2)
            }
        }
        .ignoresSafeArea(edges: .bottom)
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
