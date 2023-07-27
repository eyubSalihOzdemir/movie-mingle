//
//  DetailedMovieView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 21.07.2023.
//

import SwiftUI
import Kingfisher

struct DetailedMovieView: View {
    @ObservedObject var moviesViewModel: MoviesViewModel
    var movie: MovieSearchResult
    
    var body: some View {
        VStack(alignment: .leading) {
            
            KFImage(URL(string: "https://image.tmdb.org/t/p/w780\(movie.backdropPath ?? "")"))
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipped()
                .overlay {
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [Color.clear, Color("Raisin black")], startPoint: .center, endPoint: .bottom)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Group {
                                    Text("\(movie.title)")
                                        .font(.title2.weight(.semibold)) +
                                    Text(movie.originalTitle.lowercased() == movie.title.lowercased() ? "" : " (\(movie.originalTitle))")
                                        .font(.title3.weight(.light))
                                        .foregroundColor(.secondary)
                                }
                                .lineLimit(2)
                                
                                Spacer()
                            }
                            
                            Text("\(moviesViewModel.getGenresText(genreIDS: movie.genreIDS))")
                                .lineLimit(1)
                                .font(.subheadline.weight(.ultraLight))
                        }
                        .padding(.horizontal, 10)
                    }
                }
            
            Group {
                if moviesViewModel.loadingMovieDetails {
                    VStack(alignment: .center) {
                        Spacer()
                        
                        ProgressView()
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    VStack(spacing: 20) {
                        Text(moviesViewModel.detailedMovie?.tagline ?? "")
                            .font(.title2.weight(.bold))
                        
                        HStack {
                            Spacer()
                            HStack(spacing: 5) {
                                Image(systemName: "calendar")
                                    .foregroundColor(.secondary)
                                Text(moviesViewModel.detailedMovie?.releaseDate ?? "")
                            }
                            Spacer()
                            HStack(spacing: 5) {
                                Image(systemName: "clock")
                                    .foregroundColor(.secondary)
                                Text(String(moviesViewModel.detailedMovie?.runtime.codingKey.stringValue ?? ""))
                            }
                            Spacer()
                            HStack(spacing: 5) {
                                Image(systemName: "location.circle")
                                    .foregroundColor(.secondary)
                                Text(moviesViewModel.countries)
                            }
                            Spacer()
                        }
                        
                        Text(moviesViewModel.importantPeople)
                        
                        // direct to "https://www.imdb.com/title/\(moviesViewModel.detailedMovie?.imdbID)/"
                        Link(destination: URL(string: "https://www.imdb.com/title/\(moviesViewModel.detailedMovie?.imdbID ?? "")/")!) {
                            HStack(spacing: 5) {
                                Text("Visit")
                                Image("imdb")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40)
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(lineWidth: 1)
                                    .frame(width: 84, height: 28)
                            }
                        }
                        
                        Text(moviesViewModel.detailedMovie?.overview ?? "")
                        
                        Text(moviesViewModel.detailedMovie?.belongsToCollection?.name ?? "")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                }
            }
            
            Spacer()
        }
        .ignoresSafeArea(edges: .top)
        .background(Color("Raisin black"))
        .onAppear {
            Task {
                await moviesViewModel.getMovieDetails(movieId: movie.id)
            }
        }
    }
}

struct DetailedMovieView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedMovieView(moviesViewModel: MoviesViewModel(), movie: MovieSearchResult(adult: false, backdropPath: "/qWQSnedj0LCUjWNp9fLcMtfgadp.jpg", genreIDS: [28,12,16], id: 667538, originalLanguage: "en", originalTitle: "Original Movie Title 1", overview: "When a new threat capable of destroying the entire planet emerges, Optimus Prime and the Autobots must team up with a powerful faction known as the Maximals. With the fate of humanity hanging in the balance, humans Noah and Elena will do whatever it takes to help the Transformers as they engage in the ultimate battle to save Earth.", popularity: 123.456, posterPath: "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg", releaseDate: "01.01.1970", title: "Movie Title 1", video: false, voteAverage: 3.1, voteCount: 31))
    }
}
