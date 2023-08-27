//
//  EventsViewModel.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 29.07.2023.
//

import Foundation
import FirebaseDatabase

@MainActor class EventsViewModel: ObservableObject {
    @Published var loading = false
    
    @Published var name = ""
    @Published var place = ""
    @Published var date = Date.now
    @Published var people: [String: Bool] = [:]
    
    @Published var events: [String: Event] = [:]
    
    @Published var showingEventCreationSheet = false
    
    private let rootRef = Database.database(url: "https://movienightplanner-c3b6c-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    init() {
        print("EventsViewModel initialized.")
    }
    
    deinit {
        print("Deinitializing EventsViewModel!")
    }
    
    func getEvents(userID: String) {
        self.rootRef.child("users/\(userID)/events").observe(.childAdded) { snapshot in
            self.rootRef.child("events/\(snapshot.key)").observe(.value) { eventSnapshot in
                if let data = try? JSONSerialization.data(withJSONObject: eventSnapshot.value as Any) {
                    do {
                        let decodedEvent = try JSONDecoder().decode(Event.self, from: data)
                        
                        self.events[snapshot.key] = decodedEvent
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func createEvent(userID: String, username: String) {
        let eventID = UUID()
        
//        let date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = .none
//        dateFormatter.dateStyle = .short
        
        if self.name.isEmpty {
            self.name = "\(username)'s Event"
        }
        
        if self.place.isEmpty {
            self.place = "\(username)'s Home"
        }
        
        self.people[userID] = true
        
        let newEvent = Event(name: self.name, place: self.place, date: self.date.formatted(date: .numeric, time: .omitted), people: self.people)

        if let encodedEvent = try? JSONEncoder().encode(newEvent) {
            guard let key = self.rootRef.child("events/\(eventID)").key else { return }

            do {
                let jsonDict = try JSONSerialization.jsonObject(with: encodedEvent)
                let eventUpdates = ["events/\(key)": jsonDict]
                self.rootRef.updateChildValues(eventUpdates)

                self.rootRef.child("users/\(userID)/events/\(key)").setValue(true)

                print("Succesfully added new event info to the database")
            } catch let error {
                print("Error! Couldn't convert JSON to Dictionary")
                print(error.localizedDescription)
            }
        }
        
        self.showingEventCreationSheet = false
    }
}
