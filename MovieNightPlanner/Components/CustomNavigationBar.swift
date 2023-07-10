//
//  CustomNavigationBar.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 8.07.2023.
//

import SwiftUI

struct CustomNavigationBar<Content: View>: View {
    let title: String
    var shouldPop: Bool = false
    let actions: () -> Content
    
    init(title: String, shouldPop: Bool = false, @ViewBuilder actions: @escaping () -> Content) {
        self.title = title
        self.shouldPop = shouldPop
        self.actions = actions
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            if shouldPop {
                Button {
                    dismiss()
                } label: {
                    NavigationBarIcon(icon: "chevron.left")
                }
                .buttonStyle(.plain)
            }
            
            Text("\(title)")
                .font(.largeTitle.weight(.semibold))
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            HStack {
                actions()
            }
        }
        .frame(height: Constants.customNavBarHeight)
        .padding(.horizontal, Constants.customNavBarHorizontalPadding)
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar(title: "Profile", shouldPop: true) {
            NavigationBarIcon(icon: "calendar")
            NavigationBarIcon(icon: "gearshape")
        }
    }
}
