//
//  MoviesView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct MoviesView: View {
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                Color.clear
                    .frame(height: 60)
                
                ForEach(0..<20, id: \.self) { movie in
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 100, height: 100)
                }
            }
            //.padding(.top, 60)
            
            CustomNavigationBar(title: "Movies") { }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
