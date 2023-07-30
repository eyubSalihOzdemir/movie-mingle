//
//  Event.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 29.07.2023.
//

import Foundation

struct Event: Codable, Comparable, Hashable {
    let date: String
    let name: String
    let participants: [String: Bool]
    
    static func <(lhs: Event, rhs: Event) -> Bool {
        //todo: create a computed property that converts 'date: String' to 'dateObj: Date' and use that Date variable to compare
        return lhs.date < rhs.date
    }
}
