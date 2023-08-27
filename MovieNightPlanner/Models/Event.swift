//
//  Event.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 29.07.2023.
//

import Foundation

struct Event: Codable, Comparable, Hashable {
    let name: String
    let place: String
    let date: String
    let creator: String
    let hexColor: String
    let people: [String: Bool]
    let movies: [EventMovie]?
    
    static func <(lhs: Event, rhs: Event) -> Bool {
        //todo: create a computed property that converts 'date: String' to 'dateObj: Date' and use that Date variable to compare
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let lhsDate = dateFormatter.date(from: lhs.date), let rhsDate = dateFormatter.date(from: rhs.date) {
            if lhsDate == rhsDate {
                return lhs.name < rhs.name
            } else {
                return lhsDate < rhsDate
            }
        } else {
            return false
        }
    }
}

struct EventMovie: Codable, Hashable, Equatable {
    let votes: [String: Bool]
}
