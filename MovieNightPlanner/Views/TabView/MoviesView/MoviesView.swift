//
//  MoviesView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct MoviesView: View {
    @State private var navigationBarHidden = false
    @State private var searchText = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            CustomScrollView(navigationBarHidden: $navigationBarHidden, searchBar: true) {
                ForEach(0..<20, id: \.self) { movie in
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 100, height: 100)
                }
            }
            
            //todo: add a search bar in a nice way and animate it's opening and closing states

            CustomNavigationBar(title: "Movies", searchBar: true) {
                
            }.offset(y: navigationBarHidden ? -100 : 0)
                
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
