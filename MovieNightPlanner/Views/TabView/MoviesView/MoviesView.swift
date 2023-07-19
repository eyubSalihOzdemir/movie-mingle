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
    
    var body: some View {
        ZStack(alignment: .top) {
            Group {
                if moviesViewModel.loading {
                    VStack {
                        ProgressView()
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    if moviesViewModel.previousSearch.isEmpty {
                        CustomScrollView(navigationBarHidden: $moviesViewModel.navigationBarHidden, searchBar: true) {
                            VStack {
                                ForEach(moviesViewModel.trendingMovies.results) { movie in
                                    Text("\(movie.title)")
                                }
                                
                                Divider()
                                
                                ForEach(moviesViewModel.upcomingMovies.results) { movie in
                                    Text("\(movie.title)")
                                }
                            }
                            //.redacted(reason: moviesViewModel.loading ? .placeholder : [])
                        }
                    } else {
                        CustomScrollView(navigationBarHidden: $moviesViewModel.navigationBarHidden, searchBar: true) {
                            VStack {
                                ForEach(moviesViewModel.movieSearchResults.results) { movie in
                                    Text("\(movie.title)")
                                }
                                
                                if moviesViewModel.movieSearchResults.results.isEmpty {
                                    Text("No results for \(moviesViewModel.previousSearch)")
                                }
                            }
                        }
                    }
                }
            }
            
            //todo: this is going to be changed to "favorites"
            CustomNavigationBar(title: "Movies", searchText: $moviesViewModel.searchText) {
                //
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
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
