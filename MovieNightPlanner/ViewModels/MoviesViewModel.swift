//
//  MoviesViewModel.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 11.07.2023.
//

import Foundation

@MainActor class MoviesViewModel: ObservableObject {
    @Published var loading: Bool
    
    @Published var navigationBarHidden: Bool
    @Published var searchText: String
    @Published var previousSearch: String
    
    @Published var movieSearchResults: MovieSearchResponse
    @Published var trendingMovies: MovieSearchResponse
    @Published var upcomingMovies: MovieSearchResponse
    
    var workItem: DispatchWorkItem?
    
    init(
        loading: Bool = false,
        navigationBarHidden: Bool = false,
        searchText: String = "",
        movieSearchResults: MovieSearchResponse = MovieSearchResponse(page: 1, results: [], totalPages: 1, totalResults: 0),
        trendingMovies: MovieSearchResponse = MovieSearchResponse(page: 1, results: [], totalPages: 1, totalResults: 0),
        upcomingMovies: MovieSearchResponse = MovieSearchResponse(page: 1, results: [], totalPages: 1, totalResults: 0),
        previousSearch: String = ""
    ) {
        self.loading = loading
        self.navigationBarHidden = navigationBarHidden
        self.searchText = searchText
        self.movieSearchResults = movieSearchResults
        self.previousSearch = previousSearch
        self.trendingMovies = trendingMovies
        self.upcomingMovies = upcomingMovies
        
        Task {
            await self.getTrendingMovies()
            await self.getUpcomingMovies()
        }
    }
    
    func getDateFromString(from: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
    }
    
    func getMovieDetails(movieId: Int) async {
        loading = true
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(Constants.apiKey)&append_to_response=credits") else {
            loading = false
            print("Invalid URL for getting movie details")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Movie.self, from: data) {
                print("Movies imdb id is: \(decodedResponse.imdbID)")
            } else {
                print("Couldn't decode response!")
            }
            //print("Data: \(String(data: data, encoding: String.Encoding.utf8))")
        } catch {
            print("Invalid data for getting movie details")
        }
        
        loading = false
    }
    
    func getMoviesBySearch() async {
        workItem?.cancel()
        
        let newWorkItem = DispatchWorkItem {
            Task {
                self.loading = true
                
                let query = self.searchText
                    .uppercased()
                    .folding(options: .diacriticInsensitive, locale: Locale(identifier: "en"))
                    .lowercased()
                    .replacingOccurrences(of: " ", with: "+")
                
                guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&include_adult=false&language=en-US&page=1&api_key=\(Constants.apiKey)") else {
                    self.loading = false
                    print("Invalid URL for movie searching")
                    return
                }
                
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    
                    if let decodedResponse = try? JSONDecoder().decode(MovieSearchResponse.self, from: data) {
                        self.previousSearch = self.searchText
                        
                        var response = decodedResponse
                        response.results.sort {
                            $0.popularity > $1.popularity
                        }
                        self.movieSearchResults = response
                    } else {
                        print("Couldn't decode response!")
                    }
                } catch {
                    print("Invalid data for seraching movie")
                }
                
                self.loading = false
            }
        }
        
        workItem = newWorkItem
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(500), execute: newWorkItem)
    }
    
    func getTrendingMovies() async {
        loading = true
        
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week?api_key=\(Constants.apiKey)") else {
            loading = false
            print("Invalid URL for movie searching")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(MovieSearchResponse.self, from: data) {
                var response = decodedResponse
                response.results.sort {
                    $0.popularity > $1.popularity
                }
                trendingMovies = response
            } else {
                print("Couldn't decode response!")
            }
        } catch {
            print("Invalid data for trending movies")
        }
        
        loading = false
    }
    
    func getUpcomingMovies() async {
        loading = true
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(Constants.apiKey)") else {
            loading = false
            print("Invalid URL for movie searching")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(MovieSearchResponse.self, from: data) {
                var response = decodedResponse
                response.results.sort {
                    $0.popularity > $1.popularity
                }
                upcomingMovies = response
            } else {
                print("Couldn't decode response!")
            }
        } catch {
            print("Invalid data for upcoming movies")
        }
        
        loading = false
    }
    
    func getGenresText(genreIDS: [Int]) -> String {
        var genreStringList = [String]()
        
        genreIDS.forEach { genreID in
            genreStringList.append(Constants.getGenre(id: genreID))
        }
        
        return genreStringList.joined(separator: ", ")
    }
}
