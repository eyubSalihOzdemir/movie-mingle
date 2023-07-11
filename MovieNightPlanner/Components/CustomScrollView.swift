//
//  CustomScrollView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 10.07.2023.
//

import SwiftUI

struct CustomScrollView<Content: View>: View {
    @Namespace private var scrollSpace
    @Binding var navigationBarHidden: Bool
    var searchBar: Bool = false
    let content: () -> Content
    
    @State private var scrollOffset: CGFloat = .zero
    
    var body: some View {
        ScrollView {
            Group {
                Color.clear
                    .frame(height: searchBar ? Constants.customNavBarHeight + Constants.searchBarHieght : Constants.customNavBarHeight)
                
                content()
                
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
                    /// scrolling up, don't show the nav bar if scroll offset is more than than 1350 points
                    if value > -1350 {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            navigationBarHidden = false
                        }
                    }
                } else {
                    /// scrolling down, don't hide the nav bar if scroll offset is less than 200 points
                    if value < -200 {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            navigationBarHidden = true
                        }
                    }
                }
                scrollOffset = value
            }
        }
        .coordinateSpace(name: scrollSpace)
    }
}

struct CustomScrollView_Previews: PreviewProvider {
    static var previews: some View {
        CustomScrollView(navigationBarHidden: .constant(false)) {
            ForEach(0..<20, id: \.self) { movie in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 100)
            }
        }
    }
}
