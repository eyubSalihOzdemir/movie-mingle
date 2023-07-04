//
//  MoviePosterView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 2.07.2023.
//

import SwiftUI

struct MoviePosterView: View {
    var name: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        /// turns out, shadows are not very efficient. don't use 3 layers of shadow for 50 images on the screen, it sucks.
        
        Image("\(name)")
            .resizable()
            .frame(width: width, height: height)
            .scaledToFit()
            //.innerShadow(shape: RoundedRectangle(cornerRadius: 20, style: .continuous), color: .black)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.white, lineWidth: 1)
            }
            //.shadow(radius: 2)
            //.shadow(radius: 5)
    }
}

struct MoviePosterView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterView(name: "3-3", width: 120*3, height: 177.6*3)
    }
}
