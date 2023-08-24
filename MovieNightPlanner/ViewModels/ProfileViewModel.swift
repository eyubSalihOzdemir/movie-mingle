//
//  ProfileViewModel.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 9.07.2023.
//

import Foundation
import FirebaseDatabase

@MainActor class ProfileViewModel: ObservableObject {
    @Published var loading: Bool
    
    @Published var toast: Toast?
    @Published var searchText: String
    @Published var previousSearch: String
    
    @Published var friends: [User] = []
    @Published var friendRequests: [User] = []
    
    private var requestedFriendID: String? = nil
    
    private var userID: String? = nil
    
    private let rootRef = Database.database(url: "https://movienightplanner-c3b6c-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    init(
        loading: Bool = false,
        toast: Toast? = nil,
        searchText: String = "",
        previousSearch: String = ""
    ) {
        self.loading = loading
        self.toast = toast
        self.searchText = searchText
        self.previousSearch = previousSearch
    }
    
    func getFriends(userID: String) {
        self.userID = userID
        //var myDatabaseHandle: DatabaseHandle!
        
        self.rootRef.child("users/\(userID)/friends").observeSingleEvent(of: .childAdded) { snapshot in
            self.rootRef.child("users/\(snapshot.key)").observe(.value) { userSnapshot in
                //self.rootRef.removeObserver(withHandle: myDatabaseHandle)
                
                if let data = try? JSONSerialization.data(withJSONObject: userSnapshot.value) {
                    do {
                        let decodedFriend = try JSONDecoder().decode(User.self, from: data)
                        
                        self.friends.append(decodedFriend)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        self.getFriendRequests(userID: userID)
    }
    
    func getFriendRequests(userID: String) {
        self.rootRef.child("requests/\(userID)/friendRequests").observe(.childAdded) { snapshot in
            self.rootRef.child("users/\(snapshot.key)").observeSingleEvent(of: .value) { userSnapshot in
                if let data = try? JSONSerialization.data(withJSONObject: userSnapshot.value) {
                    do {
                        let decodedFriendRequestedUser = try JSONDecoder().decode(User.self, from: data)
                        
                        self.friendRequests.append(decodedFriendRequestedUser)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func sendFriendRequest() async {
        self.loading = true
        
        guard let userID = self.userID else { return }
        
        let query = self.searchText
            .uppercased()
            .folding(options: .diacriticInsensitive, locale: Locale(identifier: "en"))
            .lowercased()
        
        self.checkUsernameAlreadyExists(username: query) { isExists in
            if !isExists {
                // show a toast saying that 'such a username doesn't exist'
                self.toast = Toast(style: .warning, message: "That username does not exist")
            } else {
                // send a friend request to that user
                //guard let key = self.rootRef.child("requests/\(userID)/ownRequests").key else { return }
                guard let friendID = self.requestedFriendID else { return }
                
                if friendID == userID {
                    self.toast = Toast(style: .warning, message: "That's you!")
                    return
                }
                
                self.checkIfAlreadyFriend(friendID: friendID) { alreadyFriend in
                    if alreadyFriend {
                        self.toast = Toast(style: .warning, message: "You are already friends")
                    } else {
                        do {
                            self.rootRef.child("requests/\(userID)/ownRequests/\(friendID)").setValue(true)
                            self.rootRef.child("requests/\(friendID)/friendRequests/\(userID)").setValue(true)
                            
                            self.toast = Toast(style: .success, message: "Friend request is sent")
                        } catch let error {
                            print("Error! Couldn't update the database")
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
        
        self.loading = false
    }
    
    func acceptFriendRequest(friendUsername: String) {
        deleteFriendRequest(friendUsername: friendUsername)
        
        guard let userID = self.userID else { return }
        
        self.getIDFromUsername(username: friendUsername) { friendID in
            self.rootRef.child("users/\(userID)/friends/\(friendID)/nickname").setValue("")
            self.rootRef.child("users/\(friendID)/friends/\(userID)/nickname").setValue("")
        }
    }
    
    func rejectFriendRequest(friendUsername: String) {
        deleteFriendRequest(friendUsername: friendUsername)
    }
    
    func deleteFriendRequest(friendUsername: String) {
        guard let userID = self.userID else { return }
        
        self.getIDFromUsername(username: friendUsername) { friendID in
            self.rootRef.child("requests/\(userID)/friendRequests/\(friendID)").removeValue()
            self.rootRef.child("requests/\(friendID)/ownRequests/\(userID)").removeValue()
        }
        
        friendRequests.removeAll { user in
            user.username == friendUsername
        }
    }
    
    func getIDFromUsername(username: String, completion: @escaping(String) -> Void) {
        //var returnedUsername = ""
        self.rootRef.child("users").queryOrdered(byChild: "username").queryEqual(toValue: username)
            .observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    if let snapshotValue = snapshot.value as? [String: Any], let friendUserID = snapshotValue.keys.first {
                        //print(friendUserID)
                        //returnedUsername = friendUserID
                        completion(friendUserID)
                    }
                }
            }
        
        //return returnedUsername
    }
    
    func checkUsernameAlreadyExists(username: String, completion: @escaping(Bool) -> Void) {
        self.rootRef.child("users").queryOrdered(byChild: "username").queryEqual(toValue: username)
            .observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    if let snapshotValue = snapshot.value as? [String: Any], let friendUserID = snapshotValue.keys.first {
                        self.requestedFriendID = friendUserID
                    }
                    
                    completion(true)
                } else{
                    completion(false)
                }
            }
    }
    
    func checkIfAlreadyFriend(friendID: String, completion: @escaping(Bool) -> Void) {
        guard let userID = self.userID else {
            completion(false)
            return
        }
        
        self.rootRef.child("users/\(userID)/friends").queryOrderedByKey().queryEqual(toValue: friendID)
            .observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
}
