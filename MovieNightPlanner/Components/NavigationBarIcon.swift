//
//  NavBarActionButton.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 8.07.2023.
//

import SwiftUI

struct NavigationBarIcon: View {
    var icon: String
    
    var body: some View {
        Image(systemName: "\(icon)")
            .font(.title2)
    }
}

struct NavBarActionButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarIcon(icon: "person")
    }
}
