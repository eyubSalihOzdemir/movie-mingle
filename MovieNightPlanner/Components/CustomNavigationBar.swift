//
//  CustomNavigationBar.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 8.07.2023.
//

import SwiftUI

struct CustomNavigationBar<Content: View>: View {
    let title: String
    var shouldPop: Bool
    var searchBar: Bool
    let actions: () -> Content
    
    init(title: String, shouldPop: Bool = false, searchBar: Bool = false, @ViewBuilder actions: @escaping () -> Content) {
        self.title = title
        self.shouldPop = shouldPop
        self.searchBar = searchBar
        self.actions = actions
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if shouldPop {
                    Button {
                        dismiss()
                    } label: {
                        NavigationBarIcon(icon: "chevron.left")
                    }
                    .buttonStyle(.plain)
                }
                
                Text("\(title)")
                    .font(.largeTitle.weight(.semibold))
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                HStack {
                    actions()
                }
            }
            
            if searchBar {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: .constant(""))
                }
                .frame(height: Constants.searchBarHieght)
                .foregroundColor(.secondary)
                .padding(.horizontal, Constants.searchBarHorizontalPadding)
                .background(Color.secondary.opacity(0.5))
                .cornerRadius(Constants.searchBarCornerRadius)
            }
        }
        .frame(height: searchBar ? Constants.customNavBarHeight + Constants.searchBarHieght : Constants.customNavBarHeight)
        .padding(.horizontal, Constants.customNavBarHorizontalPadding)
        //.background(.red)
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar(title: "Profile", shouldPop: true, searchBar: true) {
            NavigationBarIcon(icon: "calendar")
            NavigationBarIcon(icon: "gearshape")
        }
    }
}
