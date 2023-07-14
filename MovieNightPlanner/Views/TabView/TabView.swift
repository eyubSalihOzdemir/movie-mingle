//
//  Fooview.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 5.07.2023.
//

import SwiftUI

struct TabView: View {
    @ObservedObject var userViewModel: UserViewModel
    @State private var selectedTab: Tab = .movies
    
    var body: some View {
        NavigationView {
            SwiftUI.TabView {
                EventsView()
                    .tabItem {
                        Label("Events", systemImage: "calendar")
                    }
                
                MoviesView()
                    .tabItem {
                        Label("Movies", systemImage: "film.stack")
                    }
                
                ProfileView(userViewModel: userViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
            .onAppear() {
                UITabBar.appearance().tintColor = UIColor.systemPink
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
