//
//  MovieSearchResult.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 11.07.2023.
//

import Foundation

struct MovieSearchResponse: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Result: Identifiable, Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//struct MovieSearchResponse: Codable {
//    let page: Int
//    let results: [Movie]
//    let totalPages: Int
//    let totalResults: Int
//}

//struct Movie: Codable {
//    let id: Int
//    let adult: Bool
//    let backdropPath: String
//    let genreIds: [Int]
//    let originalLanguage: String
//    let originalTitle: String
//    let title: String
//    let overview: String
//    let popularity: Double
//    let posterPath: String
//    let releaseDate: String
//    let voteAverage: Double
//    let voteCount: Int
//}
