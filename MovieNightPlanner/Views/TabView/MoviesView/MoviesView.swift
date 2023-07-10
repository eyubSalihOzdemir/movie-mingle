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
    @Namespace var scrollSpace
    @State private var scrollOffset: CGFloat = 0
    @State private var navigationBarHidden = false
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                Group {
                    Color.clear
                        .frame(height: Constants.customNavBarHeight)
                    
                    ForEach(0..<20, id: \.self) { movie in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 100, height: 100)
                    }
                    
                    Color.clear
                        .frame(height: Constants.customTabBarHeight)
                }
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .named(scrollSpace)).origin.y)
                    }
                )
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    if value > scrollOffset {
                        print("Scroll UP")
                        //withAnimation {
                        //    navigationBarHidden = false
                        //}
                    } else {
                        print("Scroll DOWN")
                        //withAnimation {
                        //    navigationBarHidden = true
                        //}
                    }
                    scrollOffset = value
                }
            }
            .coordinateSpace(name: scrollSpace)

            CustomNavigationBar(title: "\(scrollOffset)") { }
                .offset(y: navigationBarHidden ? -100 : 0)
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
