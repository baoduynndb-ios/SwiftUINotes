//
//  NotesViewModel.swift
//  BaoDuyNotes
//
//  Created by Trường Khoa on 08/05/2024.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore

class NotesViewModel: ObservableObject {
    
    @Published var allUsers = [User]()
    @Published var userNotes = [DetailNote]()
    @Published var currentUser = User(id: "", name: "", notes: [])
    
    let db = Firestore.firestore()
    
    func getAllUser() {
        self.db.collection("users").getDocuments { [weak self] snapshot, error in
            
            if error != nil {
                //baonnd: Handle Error
                return
            }
            
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    self?.allUsers.removeAll()
                    self?.allUsers = snapshot.documents.map { data in
                        let listNotes = data["notes"] as? [String] ?? []
                        var listDetailNote:[DetailNote] = []
                        for note in listNotes {
                            let itemNote : [String] = note.components(separatedBy: ":")
                            listDetailNote.append(DetailNote(id: "\(listDetailNote.count)", title: itemNote.first ?? "", content: itemNote.last ?? ""))
                        }
                        return User(id: data.documentID, name: data["name"] as? String ?? "", notes: listDetailNote)
                    }
                }
            }
            
        }
    }
    
    func getNoteUser(user: User) {
        
        self.db.collection("users").document(user.id).getDocument { [weak self] snapshot, error in
            
            if error != nil {
                //baonnd: Handle Error
                return
            }
            
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    let listNotes = snapshot.data()?["notes"] as? [String] ?? []
                    var listDetailNote:[DetailNote] = []
                    for note in listNotes {
                        let itemNote : [String] = note.components(separatedBy: ":")
                        listDetailNote.append(DetailNote(id: "\(listDetailNote.count)", title: itemNote.first ?? "", content: itemNote.last ?? ""))
                    }
                    self?.currentUser = User(id: user.id, name: user.name, notes: listDetailNote)
                }
            }
        }
    }

    func createNote(user: User, title: String, content: String) {
        
        self.db.collection("users").document(user.id).getDocument { [weak self] snapshot, error in
            if error != nil {
                //baonnd: Handle Error
                return
            }
            if let snapshot = snapshot {
                var note = snapshot.data()?["notes"] as? [String] ?? []
                note.append("\(title): \(content)")
                let userData : [String:Any] = [
                    "name" : "\(user.name)",
                    "notes" : note
                ]
                do {
                    try self?.db.collection("users").document("\(user.id)").setData(userData)
                } catch let insertError {
                    print("baonnd: Error insert: \(insertError)")
                }
            }
        }
    }
    
}
