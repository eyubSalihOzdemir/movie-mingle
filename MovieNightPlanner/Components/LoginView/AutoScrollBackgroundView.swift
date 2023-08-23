//
//  AutoScrollView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 2.07.2023.
//

import SwiftUI

struct AutoScrollBackgroundView: View {
    @State private var yOffset: CGFloat = 0
    @State private var xOffset: CGFloat = 0
    @State private var alternateOffset: CGFloat = -(177.6 / 2)
    
    @State private var itemHeight = CGFloat(177.6)
    @State private var itemWidth = CGFloat(120)
    @State private var topPadding = CGFloat(5)
    @State private var bottomPadding = CGFloat(5)
    
    var numbers = Array(1...10)
    
    /// get a random number at the beginning to be able and use it with modulus to column number, to change the column places. so that images can show up on different places (columns) on every load.
    let randomInt = Int.random(in: 1..<100)

    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                ForEach(randomInt..<randomInt + 5) { columnNumber in
                    if columnNumber % 2 == 0 {
                        ScrollingColumn(columnNumber: columnNumber % 5 + 1, numbers: numbers, itemWidth: itemWidth, itemHeight: itemHeight, topPadding: topPadding, bottomPadding: bottomPadding, yOffset: $yOffset)
                    } else {
                        ScrollingColumn(columnNumber: columnNumber % 5 + 1, numbers: numbers, itemWidth: itemWidth, itemHeight: itemHeight, topPadding: topPadding, bottomPadding: bottomPadding, yOffset: $alternateOffset)
                    }
                }
            }
        }
        .frame(height: 1000)
        .disabled(true)
        .rotationEffect(.degrees(-20))
        .onAppear {
            withAnimation(.linear(duration: 60).repeatForever(autoreverses: false)) {
                /// when you multiply the item height with the item count, you get the full column height. you use that as an offset and by the time the animation ends, the column will be returned to its original place and will start again without the user noticing
                yOffset = -(CGFloat(numbers.count)) * (itemHeight + topPadding + bottomPadding)
                alternateOffset = (-(CGFloat(numbers.count)) * (itemHeight + topPadding + bottomPadding)) - (177.6 / 2)
            }
        }
        .ignoresSafeArea()
    }
}

struct AutoScrollView_Previews: PreviewProvider {
    static var previews: some View {
        AutoScrollBackgroundView()
    }
}

struct ScrollingColumn: View {
    var columnNumber: Int
    var numbers: [Int]
    var itemWidth: CGFloat
    var itemHeight: CGFloat
    var topPadding: CGFloat
    var bottomPadding: CGFloat
    
    @Binding var yOffset: CGFloat
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(spacing: 0) {
                ForEach(numbers, id: \.self) { number in
                    MoviePosterView(name: "\(columnNumber)-\(number)", width: itemWidth, height: itemHeight)
                    //RoundedRectangle(cornerRadius: 10)
                        //.frame(width: itemWidth, height: itemHeight)
                        .padding(.top, topPadding)
                        .padding(.bottom, bottomPadding)
                }
            }
            
            VStack(spacing: 0) {
                ForEach(numbers, id: \.self) { number in
                    MoviePosterView(name: "\(columnNumber)-\(number)", width: itemWidth, height: itemHeight)
                    //RoundedRectangle(cornerRadius: 10)
                        //.frame(width: itemWidth, height: itemHeight)
                        .padding(.top, topPadding)
                        .padding(.bottom, bottomPadding)
                }
            }
        }
        .offset(y: yOffset)
         

        
    }
}
