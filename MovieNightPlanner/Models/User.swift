//
//  UserModel.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 8.07.2023.
//

//   let user = try? JSONDecoder().decode(User.self, from: jsonData)

import Foundation

// MARK: - User
struct User: Codable {
    //let id: String
    let username: String
    let avatar: String
    let events: [Event]?
    let favoriteMovies: [Movie]?
    let friends: [Friend]?
}

// MARK: - Event
struct Event: Codable {
    let id: Bool
}

// MARK: - Movie
struct Movie: Codable {
    let id: Bool
}

// MARK: - Friend
struct Friend: Codable {
    let nickname: String?
}
