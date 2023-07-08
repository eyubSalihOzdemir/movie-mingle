//
//  UserViewModel.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 4.07.2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import SwiftUI

@MainActor class UserViewModel: ObservableObject {
    @Published var loading = false
    
    @Published var isShowingLoginTab = true
    
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var avatar = ""
    
    @Published var signedIn = false
    
    var user: FirebaseAuth.User? {
        didSet {
            objectWillChange.send()
        }
    }
    
    init() {
        print("UserViewModel initialized.")
        
        listenToAuthState()
    }
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            
            self.user = user
        }
    }
    
    // MARK: Sign in
    func signIn() {
        if !self.loading {
            withAnimation {
                self.loading = true
            }
            
            Auth.auth().signIn(withEmail: self.email, password: self.password) { [weak self] authResult, error in
                guard self != nil else { return }
                
                if authResult != nil {
                    print("Successfully signed in!")
                    //
                    self?.signedIn = true
                }
                
                if let error = error {
                    print("There was an error during login!")
                    print(error.localizedDescription)
                    //
                }
                
                withAnimation {
                    self?.loading = false
                }
            }
        }
    }
    
    func checkUsernameAlreadyExists(username: String, completion: @escaping(Bool) -> Void) {
        let ref = Database.database(url: "https://movienightplanner-c3b6c-default-rtdb.europe-west1.firebasedatabase.app/").reference()
        ref.child("users").queryOrdered(byChild: "username").queryEqual(toValue: username)
            .observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    completion(true)
                } else{
                    completion(false)
                }
            }
    }
    
    // MARK: Sign Up
    func signUp() {
        if !self.loading {
            withAnimation {
                self.loading = true
            }
            
            checkUsernameAlreadyExists(username: username) { isExist in
                if isExist {
                    print("Username already exists!")
                    
                    withAnimation {
                        self.loading = false
                    }
                } else {
                    print("Username doesn't exist!")
                    Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                        if authResult != nil {
                            print("Successfully signed up!")
                            
                            /// Updates the user displayName from username
                            self.updateUsername()
                            
                            ///Create a User model
                            let randomInt = Int.random(in: 1..<79)
                            let newUser = User(id: authResult!.user.uid, username: self.username, avatar: String(format: "%03d", randomInt), events: nil, favoriteMovies: nil, friends: nil)
                            if let encoded = try? JSONEncoder().encode(newUser) {
                                print("\(String(data: encoded, encoding: .utf8)!)")
                            }
                            
                            //todo: and then create a databse node for the new user
                        }
                        
                        if let error = error {
                            print("There was an error during sign up!")
                            print(error.localizedDescription)
                            //
                        }
                        
                        withAnimation {
                            self.loading = false
                        }
                    }
                }
            }
        }
    }
    
    func updateUsername() {
        let changeRequest = self.user?.createProfileChangeRequest()
        changeRequest?.displayName = self.username
        changeRequest?.commitChanges { error in
            if let error = error {
                print("Error! Couldn't update display name!")
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Sign Out
    func signOut() {
        self.loading = true
        
        self.isShowingLoginTab = true
        self.username = ""
        self.password = ""
        self.email = ""
        
        do {
          try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
        self.loading = false
    }
    
    func forgotPassword() {
        //
    }
}
