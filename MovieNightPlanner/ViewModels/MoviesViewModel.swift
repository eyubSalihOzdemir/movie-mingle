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
    @Published var userDidNotSearchYet = true
    
    func getDateFromString(from: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
    }
    
    func getMoviesBySearch() async {
        loading = true
        
        let query = searchText
            .folding(options: .diacriticInsensitive, locale: Locale(identifier: "en"))
            .lowercased()
            .replacingOccurrences(of: " ", with: "+")
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&include_adult=false&language=en-US&page=1&api_key=\(Constants.apiKey)") else {
            loading = false
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(MovieSearchResponse.self, from: data) {
                movieSearchResults = decodedResponse
            } else {
                loading = false
                print("Couldn't decode response!")
                return
            }
        } catch {
            print("Invalid data")
        }
        
        userDidNotSearchYet = false
        loading = false
    }
}
