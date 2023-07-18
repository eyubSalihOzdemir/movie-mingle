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
    var searchText: Binding<String>?
    let actions: () -> Content
    
    init(title: String, shouldPop: Bool = false, searchText: Binding<String>? = nil, @ViewBuilder actions: @escaping () -> Content) {
        self.title = title
        self.shouldPop = shouldPop
        self.searchText = searchText
        self.actions = actions
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 5) {
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
            
            if searchText != nil {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField(Constants.searchBarText, text: searchText!)
                    if !(searchText?.wrappedValue == "") {
                        Button {
                            searchText?.wrappedValue = ""
                        } label: {
                            Image(systemName: "xmark.circle")
                        }
                    }
                }
                .frame(height: Constants.searchBarHieght)
                .foregroundColor(.secondary)
                .padding(.horizontal, Constants.searchBarHorizontalPadding)
                .background(Color.secondary.opacity(0.5))
                .cornerRadius(Constants.searchBarCornerRadius)
            }
        }
        .frame(height: searchText != nil ? 5 + Constants.customNavBarHeight + Constants.searchBarHieght : Constants.customNavBarHeight)
        .padding(.horizontal, Constants.customNavBarHorizontalPadding)
        //.background(.red)
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar(title: "Profile", shouldPop: true) {
            NavigationBarIcon(icon: "calendar")
            NavigationBarIcon(icon: "gearshape")
        }
    }
}
