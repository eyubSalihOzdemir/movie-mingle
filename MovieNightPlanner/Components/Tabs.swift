//
//  Tabs.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 6.07.2023.
//

import Foundation
import SwiftUI

enum Tab: CaseIterable {
    case events, movies, profile
}

struct TabItem: Identifiable {
    let id = UUID()
    var title: String
    var icon: String
    var tab: Tab
}

var tabItems = [
    TabItem(title: "Events", icon: "calendar", tab: .events),
    TabItem(title: "Movies", icon: "film.stack", tab: .movies),
    TabItem(title: "Profile", icon: "person", tab: .profile)
]
