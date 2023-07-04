//
//  LoginTabView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 3.07.2023.
//

import SwiftUI

struct LoginTabView: View {
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    
    @Binding var isShowingLoginTab: Bool
    
    var namespace: Namespace.ID
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("Welcome Back!")
                    .font(.system(size: 30, weight: .semibold))
                    .multilineTextAlignment(.center)
                
                Text("Create movie night events and invite your friends")
                    .font(.headline.weight(.medium))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
            .padding(.horizontal)
            
            VStack(spacing: 20) {
                CustomTextField(title: "Email address", text: $emailAddress, leadingIcon: "envelope", keyboardType: .emailAddress)
                    
                CustomTextField(title: "Password", text: $password, leadingIcon: "key", isPassword: true)
            }
            .padding(.top, 30)
            .matchedGeometryEffect(id: "textfields", in: namespace)
            
            VStack {
                Button {
                    // sign in
                } label: {
                    ZStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(LinearGradient(colors: [Color(hex: "9C3FE4"), Color(hex: "C65647")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        
                        Text("Sign In")
                            .font(.title2.weight(.semibold))
                    }
                    .frame(width: 350, height: 50)
                    .padding(.top, 20)
                }
                .buttonStyle(.plain)
                
                Button {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        isShowingLoginTab.toggle()
                    }
                } label: {
                    Text("or Sign Up")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
            }
            .padding(.bottom, 50)
            .matchedGeometryEffect(id: "siginButton", in: namespace)
        }
        .frame(maxWidth: .infinity)
        .background(
            Color.clear.background(.ultraThinMaterial)
                .matchedGeometryEffect(id: "background", in: namespace)
        )
        //.background(Color.white.opacity(0.2))
        //.backgroundBlur(radius: 20, opaque: true)
        .cornerRadius(30, corners: [.topLeft, .topRight])
    }
}

struct LoginTabView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        LoginTabView(isShowingLoginTab: .constant(false), namespace: namespace)
            .preferredColorScheme(.dark)
    }
}
