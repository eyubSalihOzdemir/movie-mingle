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
        VStack {
            CustomNavigationBar(title: "Events") {
                Button {
                    eventsViewModel.showingEventCreationSheet.toggle()
                } label: {
                    NavigationBarIcon(icon: "plus")
                }
            }
            
            ScrollView {
                
                ForEach(eventsViewModel.events.values.sorted(), id: \.self) { event in
                    VStack {
                        Text(event.name)
                            .padding(.bottom, 20)
                        
                        Spacer()
                        
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Image(systemName: "calendar")
                                    
                                    Text(event.date)
                                }
                                
                                HStack {
                                    Image(systemName: "location")
                                    
                                    Text(event.place)
                                }
                            }
                            
                            Spacer()
                            
                            Text("Creator: \(event.creator)")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color(hex: "\(event.hexColor)").opacity(0.75), lineWidth: 4)
                    )
                    .background(LinearGradient(colors: [Color(hex: "\(event.hexColor)").opacity(0.1), Color("Raisin black").opacity(0.1)], startPoint: .top, endPoint: .bottom))
                    .mask {
                        RoundedRectangle(cornerRadius: 18)
                    }
                    .padding(.horizontal, Constants.customNavBarHorizontalPadding)
                    .padding(.top, 2)
                }
            }
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
