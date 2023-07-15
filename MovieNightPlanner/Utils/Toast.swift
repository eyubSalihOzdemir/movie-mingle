//
//  Toast.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 15.07.2023.
//

import Foundation
import SwiftUI

enum ToastStyle {
    case error
    case warning
    case success
    case info
}

struct Toast: Equatable {
    var style: ToastStyle
    var message: String
    var duration: Double = 2
    var width: Double = .infinity
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error:
            return Color.red
        case .warning:
            return Color.orange
        case .success:
            return Color.green
        case .info:
            return Color.blue
        }
    }
    
    var iconFileName: String {
        switch self {
        case .error:
            return "xmark.circle.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        case .success:
            return "checkmark.circle.fill"
        case .info:
            return "info.circle.fill"
        }
    }
}
