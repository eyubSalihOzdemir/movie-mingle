//
//  Event.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 29.07.2023.
//

import Foundation

struct Event: Codable {
    let date: String
    let name: String
    let participants: [Participant]
}

struct Participant: Codable {
    let id: Bool
}
