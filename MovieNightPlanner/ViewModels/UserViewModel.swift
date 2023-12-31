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
    
    @Published var toast: Toast? = nil
    
    @Published var user: User? = nil
    
    private let rootRef = Database.database(url: "https://movienightplanner-c3b6c-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    var handle: AuthStateDidChangeListenerHandle?
    
    var authUser: FirebaseAuth.User? {
        didSet {
            objectWillChange.send()
        }
    }
    
    init() {
        print("UserViewModel initialized.")
        
        self.listenToAuthState()
    }
    
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func listenToAuthState() {
        self.handle = Auth.auth().addStateDidChangeListener { _, user in
            if let user = user {
                self.authUser = user
                self.rootRef.child("users/\(user.uid)").observe(.value) { snapshot in
                    if let data = try? JSONSerialization.data(withJSONObject: snapshot.value as Any) {
                        if let decodedUser = try? JSONDecoder().decode(User.self, from: data) {
                            self.user = decodedUser
                            
                            /// just to make some things easier
                            self.username = decodedUser.username
                        } else {
                            print("Error! Couldn't read database snapshot")
                        }
                    }
                }
            } else {
                self.authUser = nil
            }
        }
    }
    
    func registerUser() {
        self.loading = true
        
        if !isValidUsername(username: self.username) {
            self.loading = false
            return
        }

        self.checkUsernameAlreadyExists(username: self.username) { isExists in
            if isExists {
                print("Username already exists!")
                self.toast = Toast(style: .error, message: "Username already exists")
                
                self.loading = false
            } else {
                Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                    if let user = authResult?.user, error == nil {
                        let newUser = User(
                            username: self.username,
                            avatar: String(format: "%03d", Int.random(in: 1..<79))
                        )
                        
                        if let encodedUser = try? JSONEncoder().encode(newUser) {
                            guard let key = self.rootRef.child("users/\(user.uid)").key else { return }
                            
                            print("Key: \(key)")
                            
                            do {
                                let jsonDict = try JSONSerialization.jsonObject(with: encodedUser)
                                let childUpdates = ["/users/\(key)": jsonDict]
                                self.rootRef.updateChildValues(childUpdates)
                                print("Succesfully added new user info to the database")
                            } catch let error {
                                print("Error! Couldn't convert JSON to Dictionary")
                                print(error.localizedDescription)
                            }
                        }
                        
                        //self.loginUser()
                    } else {
                        self.toast = Toast(style: .error, message: error?.localizedDescription ?? "")
                        
                        print("Error in createUser: \(error?.localizedDescription ?? "")")
                    }
                    
                    self.loading = false
                }
            }
        }
    }
    
    func loginUser() {
        self.loading = true
        
        Auth.auth().signIn(withEmail: self.email, password: self.password) { user, error in
            if let error = error, user == nil {
                self.toast = Toast(style: .error, message: error.localizedDescription)
                
                print("Error in login: \(error.localizedDescription)")
            }
            
            self.loading = false
        }
    }
    
    func logout() {
        self.isShowingLoginTab = true
        
        self.username = ""
        self.password = ""
        self.email = ""
        self.avatar = ""
        
        self.user = nil
        self.authUser = nil
        
        do {
            try Auth.auth().signOut()
            print("Signed out")
        } catch let signOutError as NSError {
            print("Error logging out: %@", signOutError)
        }
    }
    
    func checkUsernameAlreadyExists(username: String, completion: @escaping(Bool) -> Void) {
        self.rootRef.child("users").queryOrdered(byChild: "username").queryEqual(toValue: username)
            .observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    completion(true)
                } else{
                    completion(false)
                }
            }
    }
    
    func isValidUsername(username: String) -> Bool {
        /// before even checking if the username is exist on the database (and disturbing it for nothing if the username is not vlaid), let's chek if it's a valid username first
        /// we have 2 rules: username must be longer than or equal to 4 characters, it must not contain any number in it
        if username.count >= 4 {
            if username.first!.isNumber {
                self.toast = Toast(style: .warning, message: "Username must not start with a number")
                return false
            } else {
                return true
            }
        } else {
            self.toast = Toast(style: .warning, message: "Username must be 4 characters long or more")
            return false
        }
    }
}
