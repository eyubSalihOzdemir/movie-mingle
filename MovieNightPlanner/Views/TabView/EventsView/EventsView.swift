//
//  EventsView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 7.07.2023.
//

import SwiftUI

struct EventsView: View {
    @StateObject var eventsViewModel = EventsViewModel()
    @ObservedObject var userViewModel: UserViewModel
    
    @State private var navigationBarHidden = false
    @State private var showingEventCreationSheet = false
    
    var body: some View {
        ZStack(alignment: .top) {
            CustomScrollView(navigationBarHidden: $navigationBarHidden) {
                ForEach(eventsViewModel.events.sorted(by: >), id: \.key) { event in
                    Text(event.value.date)
                }
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
                    eventsViewModel.createEvent(userID: userViewModel.authUser!.uid)
                } label: {
                    Text("Create event")
                        .frame(width: 200, height: 100)
                        .background(Color("Platinum"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .onAppear {
            eventsViewModel.getEvents(userID: userViewModel.authUser!.uid)
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(userViewModel: UserViewModel())
    }
}
