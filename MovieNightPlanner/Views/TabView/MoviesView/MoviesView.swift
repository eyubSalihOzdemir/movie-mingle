//
//  MoviesView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct MoviesView: View {
    @StateObject var moviesViewModel = MoviesViewModel()
    
    @State private var movieToShowDetails: MovieSearchResult? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            Group {
                if moviesViewModel.loadingMoviesView {
                    VStack {
                        ProgressView()
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    if moviesViewModel.previousSearch.isEmpty {
                        CustomScrollView(navigationBarHidden: $moviesViewModel.navigationBarHidden, searchBar: true) {
                            VStack(spacing: 30) {
                                VStack {
                                    HStack {
                                        Text("Trending Movies")
                                            .font(.title2.weight(.semibold))
                                        
                                        Spacer()
                                    }
                                    
                                    HorizontalMoviesSlider(moviesViewModel: moviesViewModel, movies: moviesViewModel.trendingMovies.results)
                                }
                                .padding(.horizontal, Constants.customNavBarHorizontalPadding)
                                
                                VStack {
                                    HStack {
                                        Text("Upcoming Movies")
                                            .font(.title2.weight(.semibold))
                                        
                                        Spacer()
                                    }
                                    
                                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                        ForEach(moviesViewModel.upcomingMovies.results) { movie in
                                            VerticalMovieCardView(moviesViewModel: moviesViewModel, movie: movie)
                                                .onTapGesture {
                                                    movieToShowDetails = movie
                                                }
                                        }
                                    }
                                }
                                .padding(.horizontal, Constants.customNavBarHorizontalPadding)
                            }
                            //.redacted(reason: moviesViewModel.loading ? .placeholder : [])
                        }
                    } else {
                        CustomScrollView(navigationBarHidden: $moviesViewModel.navigationBarHidden, searchBar: true) {
                            VStack {
                                ForEach(moviesViewModel.movieSearchResults.results) { movie in
                                    MovieSearchCardView(moviesViewModel: moviesViewModel, movie: movie)
                                }
                                
                                if moviesViewModel.movieSearchResults.results.isEmpty {
                                    Text("No results for \(moviesViewModel.previousSearch)")
                                }
                            }
                            .padding(.horizontal, Constants.customNavBarHorizontalPadding)
                        }
                    }
                }
            }
            
            CustomNavigationBar(title: "Movies", searchText: $moviesViewModel.searchText) {
                //todo: add a "Favorites" button here
            }
            .background(.thinMaterial)
            .offset(y: moviesViewModel.navigationBarHidden ? -200 : 0)
            .onChange(of: moviesViewModel.searchText) { newValue in
                if !newValue.isEmpty {
                    Task {
                        await moviesViewModel.getMoviesBySearch()
                    }
                } else {
                    moviesViewModel.previousSearch = ""
                    moviesViewModel.workItem?.cancel()
                }
            }
        }
        .background(Color("Raisin black"))
        .sheet(item: $movieToShowDetails, content: { movie in
            DetailedMovieView(moviesViewModel: moviesViewModel, movie: movie)
        })
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
