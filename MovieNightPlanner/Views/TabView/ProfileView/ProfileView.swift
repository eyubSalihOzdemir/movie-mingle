//
//  ProfileView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
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
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(loginViewModel: LoginViewModel())
            .preferredColorScheme(.light)
    }
}
