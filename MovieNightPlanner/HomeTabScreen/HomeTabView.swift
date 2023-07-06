//
//  Fooview.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 5.07.2023.
//

import SwiftUI

struct HomeTabView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    @State private var selectedTab: Tab = .events
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .events:
                    VStack {
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 100, height: 100)
                    }
                    .padding(.bottom, 100)
                case .movies:
                    ScrollView {
                        ForEach(0..<20, id: \.self) { movie in
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 100, height: 100)
                        }
                    }
                    .ignoresSafeArea(edges: [.bottom])
                case .profile:
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                    }
                    .padding(.bottom, 100)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.red)
            
            HStack {
                ForEach(tabItems) { tabItem in
                    Button {
                        selectedTab = tabItem.tab
                    } label: {
                        VStack {
                            Image(systemName: "\(tabItem.icon)")
                            
                            Text("\(tabItem.title)")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(selectedTab == tabItem.tab ? .primary : .secondary)
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 16)
            .frame(height: 85, alignment: .top)
            .background(.ultraThinMaterial)
            .cornerRadius(40, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView(loginViewModel: LoginViewModel())
            .preferredColorScheme(.dark)
    }
}
