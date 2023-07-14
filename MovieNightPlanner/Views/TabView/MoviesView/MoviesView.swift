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
                if moviesViewModel.userDidNotSearchYet {
                    VStack {
                        Text("Search for movies")
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    Group {
                        if moviesViewModel.loading {
                            VStack {
                                ProgressView()
                            }
                            .frame(maxHeight: .infinity)
                        } else {
                            CustomScrollView(navigationBarHidden: $moviesViewModel.navigationBarHidden, searchBar: true) {
                                Group {
                                    if moviesViewModel.movieSearchResults.results.isEmpty {
                                        Text("No results")
                                    } else {
                                        LazyVGrid(columns: [GridItem(.flexible())]) {
                                            ForEach(moviesViewModel.movieSearchResults.results) { result in
                                                VStack {
                                                    MovieCardView(title: result.title, originalTitle: result.originalTitle, releaseDate: result.releaseDate, originalLanguage: result.originalLanguage, posterPath: result.posterPath)
                                                }
                                            }
                                            .padding(.horizontal, Constants.customNavBarHorizontalPadding)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            CustomNavigationBar(title: "Movies", searchText: $moviesViewModel.searchText) {
                Button {
                    if moviesViewModel.searchText != "" {
                        Task {
                            await moviesViewModel.getMoviesBySearch()
                        }
                    }
                } label: {
                    Text("Search")
                }
                .buttonStyle(.plain)
            }
            .background(.ultraThinMaterial)
            .offset(y: moviesViewModel.navigationBarHidden ? -200 : 0)
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
