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
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .events:
                    EventsView()
                        .padding(.bottom, 100)
                case .movies:
                    MoviesView()
                        .ignoresSafeArea(edges: [.bottom])
                case .profile:
                    ProfileView()
                        .padding(.bottom, 100)
                }
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.red)
            
            HStack {
                ForEach(tabItems) { tabItem in
                    TabItemView(title: tabItem.title, icon: tabItem.icon)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            selectedTab = tabItem.tab
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
            .cornerRadius(40, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView(loginViewModel: LoginViewModel())
            .preferredColorScheme(.dark)
    }
}
