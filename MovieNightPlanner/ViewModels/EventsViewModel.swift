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
    
    @Published var eventName = ""
    
    @Published var events: [String: Event] = [:]
    
    private let rootRef = Database.database(url: "https://movienightplanner-c3b6c-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    init() {
        print("EventsViewModel initialized.")
    }
    
    func getEvents(userID: String) {
        self.rootRef.child("users/\(userID)/events").observe(.childAdded) { snapshot in
            //print(snapshot.value)
        }
    }
    
    func createEvent(userID: String) {
        let eventID = UUID()
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        
        let newEvent = Event(date: dateFormatter.string(from: date), name: self.eventName)

        if let encodedEvent = try? JSONEncoder().encode(newEvent) {
            guard let key = self.rootRef.child("events/\(eventID)").key else { return }

            do {
                let jsonDict = try JSONSerialization.jsonObject(with: encodedEvent)
                let eventUpdates = ["events/\(key)": jsonDict]
                self.rootRef.updateChildValues(eventUpdates) { error, ref in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        self.rootRef.child("events/\(key)/participants/\(userID)").setValue(true)
                    }
                }
                
                self.rootRef.child("users/\(userID)/events/\(key)").setValue(true)
                
                print("Succesfully added new event info to the database")
            } catch let error {
                print("Error! Couldn't convert JSON to Dictionary")
                print(error.localizedDescription)
            }
        }
    }
}
