//
//  MovieNightPlannerApp.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 1.07.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()

      return true
  }
}

@main
struct MovieNightPlannerApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
