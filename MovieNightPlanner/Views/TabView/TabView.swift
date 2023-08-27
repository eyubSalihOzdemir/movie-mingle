//
//  Fooview.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 5.07.2023.
//

import SwiftUI

struct TabView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    @State private var selection = 1
    var body: some View {
        NavigationView {
            SwiftUI.TabView(selection: $selection) {
                EventsView(userViewModel: userViewModel)
                    .tabItem {
                        Label("Events", image: "eventsIcon_white")
                    }
                    .tag(1)
                
                MoviesView()
                    .tabItem {
                        Label("Movies", image: "moviesIcon_white")
                    }
                    .tag(2)
                
                ProfileView(userViewModel: userViewModel)
                    .tabItem {
                        Label("Profile", image: "profileIcon_white")
                    }
                    .tag(3)
            }
            .onAppear() {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemThinMaterial)
                //appearance.selectionIndicatorTintColor = UIColor(Color.red)
                appearance.selectionIndicatorImage = UIImage(systemName: "square.and.arrow.up")
                appearance.selectionIndicatorTintColor = UIColor(Color.blue)
                
                // Use this appearance when scrolling behind the TabView:
                //UITabBar.appearance().standardAppearance = appearance
                // Use this appearance when scrolled all the way up:
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView(userViewModel: UserViewModel())
    }
}
