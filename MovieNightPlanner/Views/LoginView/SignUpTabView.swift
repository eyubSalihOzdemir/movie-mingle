//
//  SignUpTabView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 3.07.2023.
//

import SwiftUI

struct SignUpTabView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    //@State private var emailAddress: String = ""
    //@State private var password: String = ""
    //@State private var username: String = ""
    
    //@Binding var isShowingLoginTab: Bool
    
    var namespace: Namespace.ID

    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                //.background(Color.white.opacity(0.2))
                //.backgroundBlur(radius: 20, opaque: true)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .ignoresSafeArea()
                .matchedGeometryEffect(id: "background", in: namespace)
            
            ScrollView {
                Text("Sign Up")
                    .font(.system(size: 40, weight: .semibold))
                
                VStack(spacing: 0) {
                    Text("Create an account")
                        .font(.system(size: 30, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .opacity(userViewModel.isShowingLoginTab ? 0 : 1)
                    
                    Text("Plan a movie night event with your friends")
                        .font(.headline.weight(.medium))
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .opacity(userViewModel.isShowingLoginTab ? 0 : 1)
                }
                .padding(.top, 10)
                .padding(.horizontal)
                
                VStack(spacing: 20) {
                    CustomTextField(title: "Email address", text: $userViewModel.email, leadingIcon: "envelope", keyboardType: .emailAddress)
                    
                    CustomTextField(title: "Username", text: $userViewModel.username, leadingIcon: "person")
                    
                    CustomTextField(title: "Password", text: $userViewModel.password, leadingIcon: "key", isPassword: true)
                }
                .padding(.top, 30)
                .matchedGeometryEffect(id: "textfields", in: namespace)
                
                VStack {
                    Button {
                        userViewModel.signUp()
                    } label: {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(LinearGradient(colors: [Color(hex: "9C3FE4"), Color(hex: "C65647")], startPoint: .topLeading, endPoint: .bottomTrailing))
                            
                            Text("Sign Up")
                                .font(.title2.weight(.semibold))
                        }
                        .frame(width: 350, height: 50)
                        .padding(.top, 20)
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            userViewModel.isShowingLoginTab.toggle()
                        }
                    } label: {
                        Text("or go back to Login")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.bottom, 50)
                .matchedGeometryEffect(id: "siginButton", in: namespace)
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(30, corners: [.topLeft, .topRight])
        }
    }
}

struct SignUpTabView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        SignUpTabView(userViewModel: UserViewModel(), namespace: namespace)
    }
}
