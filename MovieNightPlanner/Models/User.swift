//
//  UserModel.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 8.07.2023.
//

//   let user = try? JSONDecoder().decode(User.self, from: jsonData)

import Foundation

struct User: Codable {
    let username: String
    let avatar: String
    let events: DictionaryValue<UserEvent>?
    let favoriteMovies: DictionaryValue<UserMovie>?
    let friends: DictionaryValue<UserFriend>?
}

struct UserEvent: Codable {
    let id: Bool
}

struct UserMovie: Codable {
    let id: Bool
}

struct UserFriend: Codable {
    let nickname: String?
}

@propertyWrapper
struct DictionaryValue<T: Codable>: Codable {
    let wrappedValue: [T]
    
    init(from decoder: Decoder) throws {
        // here I decode the json as a dictionary, but keep only the values
        let dict = try [String: T](from: decoder)
        wrappedValue = Array(dict.values)
    }
    
    func encode(to encoder: Encoder) throws {
        // you can only encode it this way,
        // since the keys are gone.
        // Consider only conforming to Decodable instead.
        try wrappedValue.encode(to: encoder)
    }
}
