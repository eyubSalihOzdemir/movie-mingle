//
//  MoviesView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct MoviesView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<20, id: \.self) { movie in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
