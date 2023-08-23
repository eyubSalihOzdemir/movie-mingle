//
//  Constants.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 10.07.2023.
//

import Foundation

struct Constants {
    static let customTabBarHeight: CGFloat = CGFloat(88)
    static let customTabBarCornerRadius: CGFloat = CGFloat(40)
    
    static let searchBarHeight: CGFloat = CGFloat(34)
    static let searchBarCornerRadius: CGFloat = CGFloat(12)
    static let searchBarHorizontalPadding: CGFloat = CGFloat(7)
    
    static let customNavBarHeight: CGFloat = CGFloat(60)
    static let customNavBarHorizontalPadding: CGFloat = CGFloat(20)
    
    static let searchBarText = "Search for a movie"
    
    static let apiAuthenticationHeader = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMTJlYmZlY2ZjOGUwNWIwNTAyOGI4OWNmMjI1Mzc1ZiIsInN1YiI6IjY0YWQzZDkxNmEzNDQ4MDBlYThlMGY5MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ"
    static let apiKey = "112ebfecfc8e05b05028b89cf225375f"
    
    static func getGenre(id: Int) -> String {
        switch id {
        case 28:
            return "Action"
        case 12:
            return "Adventure"
        case 16:
            return "Animation"
        case 35:
            return "Comedy"
        case 80:
            return "Crime"
        case 99:
            return "Documentary"
        case 18:
            return "Drama"
        case 10751:
            return "Family"
        case 14:
            return "Fantasy"
        case 36:
            return "History"
        case 27:
            return "Horror"
        case 10402:
            return "Music"
        case 9648:
            return "Mystery"
        case 10749:
            return "Romance"
        case 878:
            return "Sci-Fi"
        case 10770:
            return "TV Movie"
        case 53:
            return "Thriller"
        case 10752:
            return "War"
        case 37:
            return "Western"
        default:
            return "Unknown"
        }
    }
}
