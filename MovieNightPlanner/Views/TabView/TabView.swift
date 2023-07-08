//
//  Fooview.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 5.07.2023.
//

import SwiftUI

struct TabView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    @State private var selectedTab: Tab = .events
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Color.indigo
                    .ignoresSafeArea()
                
                Group {
                    switch selectedTab {
                    case .events:
                        EventsView()
                            .padding(.bottom, 100)
                    case .movies:
                        MoviesView()
                            .ignoresSafeArea(edges: [.bottom])
                    case .profile:
                        ProfileView(loginViewModel: loginViewModel)
                            .padding(.bottom, 100)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //.background(.red)
                
                HStack {
                    ForEach(tabItems) { tabItem in
                        TabItemView(title: tabItem.title, icon: tabItem.icon)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedTab = tabItem.tab
                                }
                            }
                            .foregroundStyle(
                                selectedTab == tabItem.tab ? .primary : .secondary
                            )
                    }
                }
                .padding(.horizontal, 8)
                .padding(.top, 14)
                .frame(height: 88, alignment: .top)
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
                .cornerRadius(40, corners: [.topLeft, .topRight])
            }
            .ignoresSafeArea(edges: [.bottom])
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView(loginViewModel: LoginViewModel())
            .preferredColorScheme(.dark)
    }
}
