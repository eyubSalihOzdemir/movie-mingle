//
//  MoviesViewModel.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 11.07.2023.
//

import Foundation

@MainActor class MoviesViewModel: ObservableObject {
    @Published var loading = false
    
    @Published var navigationBarHidden = false
    @Published var searchText = ""
    @Published var movieSearchResults = MovieSearchResponse(page: 1, results: [], totalPages: 1, totalResults: 0)
    @Published var previousSearch = ""
    
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
        loading = true
        
        previousSearch = searchText
        
        let query = searchText
            .folding(options: .diacriticInsensitive, locale: Locale(identifier: "en"))
            .lowercased()
            .replacingOccurrences(of: " ", with: "+")
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&include_adult=false&language=en-US&page=1&api_key=\(Constants.apiKey)") else {
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
                movieSearchResults = response
            } else {
                print("Couldn't decode response!")
            }
        } catch {
            print("Invalid data for seraching movie")
        }
        
        loading = false
    }
}
