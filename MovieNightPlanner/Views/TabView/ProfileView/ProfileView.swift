//
//  ProfileView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    
    @ObservedObject var userViewModel: UserViewModel
    
    @State private var showingFriendsSheet = false
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(title: "Profile") {
                    Button {
                        showingFriendsSheet.toggle()
                    } label: {
                        ZStack {
                            NavigationBarIcon(icon: "person.2")
                                .overlay {
                                    if !profileViewModel.friendRequests.isEmpty {
                                        VStack {
                                            HStack {
                                                Spacer()
                                                
                                                Circle()
                                                    .fill(Color.red)
                                                    .frame(width: 12, height: 12)
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                }
                        }
                    }
                    
                    NavigationLink {
                        //todo: navigate to settings screen
                    } label: {
                        NavigationBarIcon(icon: "gearshape")
                    }
                }
                
                Image(userViewModel.user?.avatar ?? "063")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .padding(10)
                    .background(Color(hex: "#f4ebd9"))
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .strokeBorder(.black, lineWidth: 3)
                    }

                Text(userViewModel.user?.username ?? "Unknown")
                    .font(.headline.weight(.semibold))
                
                Spacer()
                
                Text("More profile feature will be listed here in the future!")
                    .font(.headline.weight(.light))
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    userViewModel.logout()
                } label: {
                    Text("Sign out")
                }
                .frame(width: 160, height: 60)
                .foregroundColor(.white)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Color.clear
                    .frame(height: 10)
            }
        }
        .background(Color("Raisin black"))
        .sheet(isPresented: $showingFriendsSheet) {
            VStack {
                CustomNavigationBar(
                    title: "Friends",
                    searchText: $profileViewModel.searchText,
                    searchBarHint: Constants.friendsSearchBarText,
                    sideButtonText: "Add friend",
                    sideButtonAction: profileViewModel.sendFriendRequest
                ) {
                    // no action button
                }
                .padding(.top, 10)
                
                Divider()
                    .padding(.horizontal, Constants.customNavBarHorizontalPadding)
                
                if !profileViewModel.friends.isEmpty {
                    ScrollView {
                        if !profileViewModel.friendRequests.isEmpty {
                            VStack {
                                HStack {
                                    Text("Requests")
                                        .font(.title3.weight(.semibold))
                                    
                                    Spacer()
                                }
                                
                                ForEach(profileViewModel.friendRequests, id: \.username) { possibleFriend in
                                    HStack {
                                        Image(possibleFriend.avatar)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40)
                                            .padding(5)
                                            .background(Color(hex: "#f4ebd9"))
                                            .clipShape(Circle())
                                            .overlay {
                                                Circle()
                                                    .strokeBorder(.black, lineWidth: 2)
                                            }
                                        
                                        Text(possibleFriend.username)
                                        
                                        Spacer()
                                        
                                        HStack {
                                            Button {
                                                profileViewModel.acceptFriendRequest(friendUsername: possibleFriend.username)
                                            } label: {
                                                Image("accept_icon")
                                                    .resizable()
                                                    .scaledToFit()
                                            }
                                            .frame(width: 24)
                                            .contentShape(Rectangle())
                                            .padding(.trailing, 10)
                                            
                                            
                                            Button {
                                                profileViewModel.rejectFriendRequest(friendUsername: possibleFriend.username)
                                            } label: {
                                                Image("reject_icon")
                                                    .resizable()
                                                    .scaledToFit()
                                            }
                                            .frame(width: 24)
                                            .contentShape(Rectangle())
                                            .padding(.trailing, 10)
                                            
                                        }
                                    }
                                }
                                
                                Divider()
                            }
                            .padding(.horizontal, Constants.customNavBarHorizontalPadding)
                        }
                        
                        ForEach(profileViewModel.friends, id: \.username) { user in
                            HStack {
                                Image(user.avatar)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40)
                                    .padding(5)
                                    .background(Color(hex: "#f4ebd9"))
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle()
                                            .strokeBorder(.black, lineWidth: 2)
                                    }
                                
                                Text(user.username)
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal, Constants.customNavBarHorizontalPadding)
                    }
                }
                
                Spacer()
            }
            .background(Color("Raisin black"))
            .toastView(toast: $profileViewModel.toast)
        }
        .onAppear {
            profileViewModel.getFriends(userID: userViewModel.authUser!.uid)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(userViewModel: UserViewModel())
        }
    }
}
