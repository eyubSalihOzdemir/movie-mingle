//
//  ProfileView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    @State private var toast: Toast? = nil
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(title: "Profile") {
                    NavigationLink {
                        //todo: navigate to settings screen
                    } label: {
                        NavigationBarIcon(icon: "gearshape")
                    }
                    .buttonStyle(.plain)
                }
                
                Image(userViewModel.currentUser?.avatar ?? "063")
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
                    .onTapGesture {
                        print("Trying to show toast")
                        toast = Toast(style: .success, message: "Saved.", width: 160)
                    }
                
                Text(userViewModel.currentUser?.username ?? "Unknown")
                    .font(.headline.weight(.semibold))
                
                Spacer()
                
                Text("More profile feature will be listed here in the future!")
                    .font(.title3.weight(.light))
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    userViewModel.signOut()
                } label: {
                    Text("Sign out")
                }
                .frame(width: 200, height: 80)
                .foregroundColor(.white)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Color.clear
                    .frame(height: 10)
            }
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
