//
//  ProfileView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        ZStack {
            VStack {
                CustomNavigationBar(title: "Profile") {
                    NavigationLink {
                        // settings screen
                    } label: {
                        NavigationBarIcon(icon: "gearshape")
                    }
                    .buttonStyle(.plain)
                }
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 100)
                
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
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userViewModel: UserViewModel())
            .preferredColorScheme(.light)
    }
}
