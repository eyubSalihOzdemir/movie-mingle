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
    
    @Published var currentUser: User? = nil
    
    @Published var toast: Toast? = nil
    
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
            
            if let user = user {
                if(self.user != user) {
                    self.user = user
                    
                    if let timeInterval = user.metadata.creationDate?.timeIntervalSinceNow {
                        /// means only get the user info if the user is not signed up in the last 10 seconds
                        /// when sign ups, the currentUser info is already saved, so this is to prevent redundancy
                        if !(timeInterval > -10) {
                            self.getUserFromDatabase(uid: user.uid)
                        }
                    }
                }
            } else {
                self.user = nil
            }
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
                                        
                    self?.signedIn = true
                }
                
                if let error = error {
                    print("There was an error during login!")
                    print(error.localizedDescription)
                    //
                    self?.toast = Toast(style: .error, message: error.localizedDescription)
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
                    self.toast = Toast(style: .error, message: "Username already exists")
                    
                    withAnimation {
                        self.loading = false
                    }
                } else {
                    print("Username doesn't exist!")
                    Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                        if authResult != nil {
                            /// Updates the user's Ffirebase.displayName from username
                            self.updateUsername()
                            
                            /// Upload newly signed up user info to database
                            self.avatar = String(format: "%03d", Int.random(in: 1..<79))
                            self.currentUser = User(username: self.username, avatar: self.avatar, events: nil, favoriteMovies: nil, friends: nil)
                            self.uploadUserToDatabase(user: self.currentUser!, id: authResult!.user.uid)
                            
                            print("Successfully signed up!")
                        }
                        
                        if let error = error {
                            print("There was an error during sign up!")
                            print(error.localizedDescription)
                            //
                            self.toast = Toast(style: .error, message: error.localizedDescription)
                        }
                        
                        withAnimation {
                            self.loading = false
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Upload user to database
    func uploadUserToDatabase(user: User, id: String) {
        if let encoded = try? JSONEncoder().encode(user) {
            let ref = Database.database(url: "https://movienightplanner-c3b6c-default-rtdb.europe-west1.firebasedatabase.app/").reference()//.child("users")
            //guard let key = ref.child(newUser.id).key else { return }
            guard let key = ref.child(id).key else { return }
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: encoded)
                let childUpdates = ["/users/\(key)": jsonDict]
                ref.updateChildValues(childUpdates)
                print("Succesfully added new user info to the database")
            } catch let error {
                print("Error! Couldn't convert JSON to Dictionary")
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Get user information from database and save to "currentUser"
    func getUserFromDatabase(uid: String) {
        let ref = Database.database(url: "https://movienightplanner-c3b6c-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("users/\(uid)")
        ref.getData { error, snapshot in
            guard error == nil else {
                print("\(error!.localizedDescription)")
                return
            }
            
            if let data = try? JSONSerialization.data(withJSONObject: snapshot?.value) {
                if let decoded = try? JSONDecoder().decode(User.self, from: data) {
                    self.currentUser = decoded
                } else {
                    print("Error! Couldn't read database snapshot")
                }
            }
        }
        
    }
    
    // MARK: Update Username
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
