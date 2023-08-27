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
    
    var body: some View {
        ZStack(alignment: .top) {
            CustomScrollView(navigationBarHidden: $navigationBarHidden) {
                ForEach(eventsViewModel.events.sorted(by: >), id: \.key) { event in
                    Text(event.value.date)
                }
            }
            
            CustomNavigationBar(title: "Events") {
                Button {
                    eventsViewModel.showingEventCreationSheet.toggle()
                } label: {
                    NavigationBarIcon(icon: "plus")
                }
            }
            .offset(y: navigationBarHidden ? -100 : 0)
        }
        .background(Color("Raisin black"))
        .sheet(isPresented: $eventsViewModel.showingEventCreationSheet) {
            VStack(alignment: .leading) {
                CustomNavigationBar(
                    title: "Event Details"
                ) {
                    // no action button
                }
                .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 20) {
                    Divider()
                    
                    HStack {
                        Text("Name")
                            .font(.headline.weight(.regular))
                        TextField("\(userViewModel.username)'s Event", text: $eventsViewModel.name)
                            .multilineTextAlignment(.trailing)
                            .font(.headline.weight(.regular))
                            .lineLimit(1)
                            .textInputAutocapitalization(.never)
                    }
                    
                    HStack {
                        Text("Place")
                            .font(.headline.weight(.regular))
                        TextField("\(userViewModel.username)'s Home", text: $eventsViewModel.place)
                            .multilineTextAlignment(.trailing)
                            .font(.headline.weight(.regular))
                            .lineLimit(1)
                            .textInputAutocapitalization(.never)
                    }
                    
                    DatePicker(selection: $eventsViewModel.date, in: Date.now..., displayedComponents: .date) {
                        Text("Select a date")
                            .font(.headline.weight(.regular))
                    }
                    .datePickerStyle(.compact)
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        Button {
                            eventsViewModel.createEvent(userID: userViewModel.authUser!.uid, username: userViewModel.username)
                        } label: {
                            Text("Create event")
                                .frame(width: 200, height: 100)
                                .background(Color("Platinum"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, Constants.customNavBarHorizontalPadding)
            }
            .frame(maxHeight: .infinity)
            .background(Color("Raisin black"))
        }
        .onAppear {
            eventsViewModel.getEvents(userID: userViewModel.authUser!.uid)
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(userViewModel: UserViewModel())
            .environmentObject(EventsViewModel())
        
    }
}
