//
//  CarouselView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 20.07.2023.
//

import SwiftUI

struct HorizontalMoviesSlider: View {
    @ObservedObject var moviesViewModel: MoviesViewModel
    
    @State private var offsetAmount: CGFloat = .zero
    @State private var index = 0
    
    var itemWidth: Int = 300
    var itemHeight: Int = 200
    var spacing: Int = 20
    var horizontalPadding: Int = 20
    var dragAmount: Int = 150
    
    var movies: [MovieSearchResult]
    
    var lastIndex: Int {
        max(movies.count - 1, 0)
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: CGFloat(spacing)) {
                ForEach(movies, id: \.id) { movie in
                    HorizontalMovieCardView(moviesViewModel: moviesViewModel, movie: movie)
                        .frame(width: CGFloat(itemWidth), height: CGFloat(itemHeight))
                }
                /// card with + spacing
                .offset(x: offsetAmount - CGFloat((itemWidth + spacing) * index))
                /// if it's last card, offset it accordingly to make it clear that it's the last card
                .offset(x: index == lastIndex ? geo.size.width - CGFloat((itemWidth)) : 0)
            }
        }
        //.padding(.horizontal, CGFloat(horizontalPadding))
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation {
                        if index == 0 && value.translation.width > 0 {
                            offsetAmount = value.translation.width / 10
                        } else if index == lastIndex && value.translation.width < 0 {
                            offsetAmount = value.translation.width / 10
                        } else {
                            offsetAmount = value.translation.width
                        }
                    }
                }
                .onEnded { value in
                    withAnimation(.spring(response: 0.3, dampingFraction: 1)) {
                        /// using predictedEndTranslation to be able to get the fast but shorter drags
                        offsetAmount = value.predictedEndTranslation.width
                        
                        if offsetAmount < CGFloat(-dragAmount) {
                            index += 1
                        } else if offsetAmount > CGFloat(dragAmount) {
                            index -= 1
                        }
                        
                        /// index should not be less than 0
                        index = max(index, 0)
                        /// and it should not be more than itemCount
                        index = min(index, lastIndex)
                        
                        offsetAmount = 0
                    }
                }
        )
        .frame(height: CGFloat(itemHeight))
    }
}

struct HorizontalMoviesSlider_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalMoviesSlider(moviesViewModel: MoviesViewModel(), movies: [
            MovieSearchResult(adult: false, backdropPath: "/qWQSnedj0LCUjWNp9fLcMtfgadp.jpg", genreIDS: [28,12,16], id: 1, originalLanguage: "en", originalTitle: "Original Movie Title 1", overview: "Overview", popularity: 123.456, posterPath: "", releaseDate: "01.01.1970", title: "Movie Title 1", video: false, voteAverage: 3.1, voteCount: 31),
            MovieSearchResult(adult: false, backdropPath: "/qWQSnedj0LCUjWNp9fLcMtfgadp.jpg", genreIDS: [28,12,16], id: 2, originalLanguage: "en", originalTitle: "Original Movie Title 2", overview: "Overview", popularity: 123.456, posterPath: "", releaseDate: "01.01.1970", title: "Movie Title 2", video: false, voteAverage: 3.1, voteCount: 31),
            MovieSearchResult(adult: false, backdropPath: "/qWQSnedj0LCUjWNp9fLcMtfgadp.jpg", genreIDS: [28,12,16], id: 3, originalLanguage: "en", originalTitle: "Original Movie Title 3", overview: "Overview", popularity: 123.456, posterPath: "", releaseDate: "01.01.1970", title: "Movie Title 3", video: false, voteAverage: 3.1, voteCount: 31),
            MovieSearchResult(adult: false, backdropPath: "/qWQSnedj0LCUjWNp9fLcMtfgadp.jpg", genreIDS: [28,12,16], id: 4, originalLanguage: "en", originalTitle: "Original Movie Title 4", overview: "Overview", popularity: 123.456, posterPath: "", releaseDate: "01.01.1970", title: "Movie Title 4", video: false, voteAverage: 3.1, voteCount: 31)
        ])
    }
}
