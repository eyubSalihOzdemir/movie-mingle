//
//  MovieDetails.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 17.07.2023.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let imdbID: String
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let overview: String
    let genres: [Genre]
    let posterPath: String?
    let backdropPath: String?
    let belongsToCollection: MovieCollection?
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let runtime: Int
    let status: String
    let tagline: String?
    let credits: Credits
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case genres, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case runtime
        case status, tagline, title
        case credits
    }
}

struct MovieCollection: Codable, Identifiable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}

struct ProductionCountry: Codable {
    let shortName: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case shortName = "iso_3166_1"
        case name
    }
}

struct Credits: Codable {
    let cast: [Cast]
}

struct Cast: Codable {
    let id: Int
    let name: String
    let popularity: Double
    let profilePath: String?
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, popularity, character
        case profilePath = "profile_path"
    }
}
