//
//  Fooview.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 5.07.2023.
//

import SwiftUI

struct Fooview: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Button {
                loginViewModel.signOut()
            } label: {
                Text("Sign out")
            }
            .foregroundColor(.white)
            .font(.headline.weight(.semibold))
            .frame(width: 250, height: 60)
            .background(.purple)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct Fooview_Previews: PreviewProvider {
    static var previews: some View {
        Fooview(loginViewModel: LoginViewModel())
    }
}
