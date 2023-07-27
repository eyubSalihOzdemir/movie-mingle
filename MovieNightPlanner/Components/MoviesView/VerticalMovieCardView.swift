//
//  VerticalMovieCardView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 21.07.2023.
//

import SwiftUI
import Kingfisher

struct VerticalMovieCardView: View {
    @ObservedObject var moviesViewModel: MoviesViewModel
    
    var movie: MovieSearchResult
    
    var width: Int = 160
    var height: Int = 220
    var padding: Int = 10
    
    var body: some View {
        ZStack {
            Color.gray
            
            KFImage(URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath ?? "")"))
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFill()
                .frame(width: CGFloat(width), height: CGFloat(height))
                .overlay {
                    LinearGradient(colors: [Color.clear, Color.black], startPoint: .center, endPoint: .bottom)
                }
            
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(movie.title)")
                            .lineLimit(2)
                            .font(.title2.weight(.semibold))
                        
                        HStack {
                            Text("\(moviesViewModel.getGenresText(genreIDS: movie.genreIDS))")
                                .lineLimit(1)
                                .font(.caption.weight(.light))
                            
                            Spacer()
                            
                            Text("\(movie.releaseDate)")
                                .lineLimit(1)
                                .font(.caption.weight(.light))
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, CGFloat(padding))
                .padding(.bottom, CGFloat(padding))
            }
        }
        .frame(width: CGFloat(width), height: CGFloat(height))
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .shadow(radius: 5)
    }
}

struct VerticalMovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalMovieCardView(moviesViewModel: MoviesViewModel(), movie: MovieSearchResult(adult: false, backdropPath: "/qWQSnedj0LCUjWNp9fLcMtfgadp.jpg", genreIDS: [28,12,16], id: 1, originalLanguage: "en", originalTitle: "Original Movie Title 1", overview: "Overview", popularity: 123.456, posterPath: "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg", releaseDate: "01.01.1970", title: "Movie Title 1", video: false, voteAverage: 3.1, voteCount: 31))
    }
}
