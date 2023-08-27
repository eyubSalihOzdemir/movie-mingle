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
    var searchBarHint: String
    var sideButtonText: String
    var sideButtonAction: (() async -> Void)?
    let actions: () -> Content
    
    init(title: String, shouldPop: Bool = false, searchText: Binding<String>? = nil, searchBarHint: String? = "Search", sideButtonText: String? = "Action", sideButtonAction: (() async -> Void)? = nil, @ViewBuilder actions: @escaping () -> Content) {
        self.title = title
        self.shouldPop = shouldPop
        self.searchText = searchText
        self.searchBarHint = searchBarHint!
        self.sideButtonText = sideButtonText!
        self.sideButtonAction = sideButtonAction
        self.actions = actions
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isSideButtonVisible = false
    
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
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField(searchBarHint, text: searchText!)
                            .textInputAutocapitalization(.never)
                        if !(searchText?.wrappedValue == "") {
                            Button {
                                searchText?.wrappedValue = ""
                            } label: {
                                Image(systemName: "xmark.circle")
                            }
                        }
                    }
                    .frame(height: Constants.searchBarHeight)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, Constants.searchBarHorizontalPadding)
                    .background(Color.secondary.opacity(0.5))
                    .cornerRadius(Constants.searchBarCornerRadius)
                    
                    if isSideButtonVisible {
                        Button {
                            Task {
                                await sideButtonAction?()
                            }
                        } label: {
                            Text(sideButtonText)
                        }
                    }
                }
                .onChange(of: searchText?.wrappedValue) { newValue in
                    if sideButtonAction != nil {
                        if newValue != "" {
                            withAnimation {
                                isSideButtonVisible = true
                            }
                        } else {
                            withAnimation {
                                isSideButtonVisible = false
                            }
                        }
                    }
                }
            }
        }
        .frame(height: searchText != nil ? 5 + Constants.customNavBarHeight + Constants.searchBarHeight : Constants.customNavBarHeight)
        .padding(.horizontal, Constants.customNavBarHorizontalPadding)
        //.background(.red)
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar(title: "Profile", shouldPop: true, searchText: .constant(""), searchBarHint: "Search for something") {
            NavigationBarIcon(icon: "calendar")
            NavigationBarIcon(icon: "gearshape")
        }
    }
}
