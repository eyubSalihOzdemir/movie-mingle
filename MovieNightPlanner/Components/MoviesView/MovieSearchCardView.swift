//
//  MovieCardView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 13.07.2023.
//

import SwiftUI
import Kingfisher

struct MovieSearchCardView: View {
    @ObservedObject var moviesViewModel: MoviesViewModel
    var movie: MovieSearchResult
    
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: movie.releaseDate)
    }
    
    var body: some View {
        HStack {
            KFImage(URL(string: "https://image.tmdb.org/t/p/w92\(movie.posterPath ?? "")"))
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .placeholder {
                    ProgressView()
                        .frame(width: 92)
                }
                .resizable()
                .scaledToFill()
                .frame(width: 92)
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(movie.title)
                        .font(.title3.weight(.semibold)) +
                    Text(movie.originalTitle.lowercased() == movie.title.lowercased() ? "" : " (\(movie.originalTitle))")
                        .font(.headline.weight(.light))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(date?.formatted(.dateTime.year()) ?? movie.releaseDate)")
                        .font(.footnote.weight(.light))
                }
                
                Text("\(moviesViewModel.getGenresText(genreIDS: movie.genreIDS))")
                    .lineLimit(1)
                    .font(.footnote.weight(.light))
                
                Spacer()
                
                Text(movie.overview)
                    .lineLimit(2)
                    .font(.footnote.weight(.light))
            }
            .padding(5)
            
            Spacer()
        }
        .frame(height: 138)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .shadow(radius: 2)
    }
}

struct MovieSearchCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchCardView(moviesViewModel: MoviesViewModel(), movie: MovieSearchResult(adult: false, backdropPath: "/qWQSnedj0LCUjWNp9fLcMtfgadp.jpg", genreIDS: [28,12,16], id: 1, originalLanguage: "en", originalTitle: "Original Movie Title 1", overview: "When a new threat capable of destroying the entire planet emerges, Optimus Prime and the Autobots must team up with a powerful faction known as the Maximals. With the fate of humanity hanging in the balance, humans Noah and Elena will do whatever it takes to help the Transformers as they engage in the ultimate battle to save Earth.", popularity: 123.456, posterPath: "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg", releaseDate: "01.01.1970", title: "Movie Title 1", video: false, voteAverage: 3.1, voteCount: 31))
    }
}
