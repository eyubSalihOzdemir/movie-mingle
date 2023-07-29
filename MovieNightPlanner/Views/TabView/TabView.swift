//
//  Fooview.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 5.07.2023.
//

import SwiftUI

struct TabView: View {
    @ObservedObject var userViewModel: UserViewModel
    //@State private var selectedTab: Tab = .movies
    @State private var selection = 1
    
    var body: some View {
        NavigationView {
            SwiftUI.TabView(selection: $selection) {
                EventsView()
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
            
            /*ZStack(alignment: .bottom) {
                Color.clear
                    .ignoresSafeArea()
                
                Group {
                    switch selectedTab {
                    case .events:
                        EventsView()
                            //.padding(.bottom, 100)
                            .ignoresSafeArea(edges: [.bottom])
                    case .movies:
                        MoviesView()
                            .ignoresSafeArea(edges: [.bottom])
                    case .profile:
                        ProfileView(userViewModel: userViewModel)
                            .padding(.bottom, 100)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack {
                    ForEach(tabItems) { tabItem in
                        TabItemView(title: tabItem.title, icon: tabItem.icon)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                //withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedTab = tabItem.tab
                                //}
                            }
                            .foregroundStyle(
                                selectedTab == tabItem.tab ? .primary : .secondary
                            )
                    }
                }
                .padding(.horizontal, 8)
                .padding(.top, 14)
                .frame(height: Constants.customTabBarHeight, alignment: .top)
                .background(.ultraThinMaterial)
                .background(
                    HStack {
                        if selectedTab == .movies { Spacer() }
                        if selectedTab == .profile {
                            Spacer()
                            Spacer()
                        }
                        Circle().fill(Color.primary).frame(width: 100, height: 80).opacity(0.8)
                        if selectedTab == .movies { Spacer() }
                        if selectedTab == .events {
                            Spacer()
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                    .frame(alignment: .center)
                )
                .cornerRadius(Constants.customTabBarCornerRadius, corners: [.topLeft, .topRight])
            }
            .ignoresSafeArea(edges: [.bottom])
             */
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView(userViewModel: UserViewModel())
    }
}
