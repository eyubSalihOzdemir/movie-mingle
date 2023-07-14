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
    let events: [UserEvent]?
    let favoriteMovies: [UserMovie]?
    let friends: [UserFriend]?
}

// MARK: - Event
struct UserEvent: Codable {
    let id: Bool
}

// MARK: - Movie
struct UserMovie: Codable {
    let id: Bool
}

// MARK: - Friend
struct UserFriend: Codable {
    let nickname: String?
}
