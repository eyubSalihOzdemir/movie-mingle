//
//  EventsView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct EventsView: View {
    @State private var navigationBarHidden = false
    
    var body: some View {
        ZStack(alignment: .top) {
            CustomScrollView(navigationBarHidden: $navigationBarHidden) {
                ForEach(0..<20, id: \.self) { movie in
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 100, height: 100)
                }
            }
            
            CustomNavigationBar(title: "Events") {
                NavigationLink {
                    //todo: show a bottom sheet for event creation
                    Text("test")
                } label: {
                    NavigationBarIcon(icon: "plus")
                }
                //.buttonStyle(.plain)
            }
            .offset(y: navigationBarHidden ? -100 : 0)
        }
        .background(Color("Raisin black"))
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
