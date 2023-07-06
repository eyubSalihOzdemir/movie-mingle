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
    var color: Color
}

var tabItems = [
    TabItem(title: "Events", icon: "calendar", tab: .events, color: .primary),
    TabItem(title: "Movies", icon: "movieclipper", tab: .movies, color: .primary),
    TabItem(title: "Profile", icon: "person", tab: .profile, color: .primary)
]
