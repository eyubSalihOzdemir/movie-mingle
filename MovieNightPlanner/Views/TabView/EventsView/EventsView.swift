//
//  EventsView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct EventsView: View {
    @StateObject var eventsViewModel = EventsViewModel()
    
    @State private var navigationBarHidden = false
    @State private var showingEventCreationSheet = false
    
    var body: some View {
        ZStack(alignment: .top) {
            CustomScrollView(navigationBarHidden: $navigationBarHidden) {
//                ForEach(0..<20, id: \.self) { movie in
//                    RoundedRectangle(cornerRadius: 20)
//                        .frame(width: 100, height: 100)
//                }
                EmptyView()
            }
            
            CustomNavigationBar(title: "Events") {
                Button {
                    showingEventCreationSheet.toggle()
                } label: {
                    NavigationBarIcon(icon: "plus")
                }

            }
            .offset(y: navigationBarHidden ? -100 : 0)
        }
        .background(Color("Raisin black"))
        .sheet(isPresented: $showingEventCreationSheet) {
            ZStack {
                Color("Raisin black")
                    .ignoresSafeArea()
                
                Button {
                    eventsViewModel.createEvent()
                } label: {
                    Text("Create event")
                        .frame(width: 200, height: 100)
                        .background(Color("Platinum"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
