//
//  TabItemView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct TabItemView: View {
    var title: String
    var icon: String
    var isBundleImage: Bool = false
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: "\(icon)")
                .font(.title2)
            
            Text("\(title)")
                .font(.footnote)
        }
    }
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(title: "Movies", icon: "person")
            .preferredColorScheme(.dark)
    }
}
