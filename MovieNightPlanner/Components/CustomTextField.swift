//
//  CustomTextField.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 3.07.2023.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    @Binding var text: String
    var leadingIcon: String?
    var iconFontSize: CGFloat = CGFloat(20)
    var iconForegroundColor: Color = .secondary
    var width: CGFloat = 350
    var height: CGFloat = 60
    var cornerRadius: CGFloat = 16
    var isPassword: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    @State private var showingPassword = false
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [Color.black, Color.black.opacity(0.2), Color.clear], center: .topLeading, startRadius: 0, endRadius: 250)
                .opacity(0.3)
            RadialGradient(colors: [Color.black, Color.black.opacity(0.2), Color.clear], center: .bottomTrailing, startRadius: 0, endRadius: 250)
                .opacity(0.3)
            
            HStack {
                if let icon = leadingIcon {
                    Image(systemName: "\(icon)")
                        .font(.system(size: iconFontSize))
                        .frame(width: 30)
                        .foregroundColor(iconForegroundColor)
                }
                
                if isPassword {
                    if showingPassword {
                        TextField(title, text: $text)
                            .lineLimit(1)
                            .keyboardType(.default)
                            .textInputAutocapitalization(.never)
                    } else {
                        SecureField(title, text: $text)
                            .lineLimit(1)
                            .keyboardType(.default)
                            .textInputAutocapitalization(.never)
                    }
                } else {
                    TextField(title, text: $text)
                        .lineLimit(1)
                        .keyboardType(keyboardType)
                        .textInputAutocapitalization(.never)
                }
                
                if isPassword {
                    Button {
                        withAnimation(.linear(duration: 0.05)) {
                            showingPassword.toggle()
                        }
                    } label: {
                        Image(systemName: showingPassword ? "eye.slash" : "eye")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
        }
        .frame(width: width, height: height)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    RadialGradient(colors: [Color.white, Color.clear], center: .init(x: 0, y: -0.5), startRadius: 20, endRadius: 200)
                )
                .mask {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(.white, lineWidth: 0.5)
                }
                .allowsHitTesting(false)
        }
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(
                    RadialGradient(colors: [Color.white, Color.clear], center: .init(x: 1, y: 0.5), startRadius: 20, endRadius: 200)
                )
                .mask {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(.white, lineWidth: 0.5)
                }
                .allowsHitTesting(false)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(title: "Email address", text: .constant(""), leadingIcon: "person", isPassword: true)
            .preferredColorScheme(.dark)
    }
}
