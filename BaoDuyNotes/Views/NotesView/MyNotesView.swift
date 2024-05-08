//
//  MyNotesView.swift
//  BaoDuyNotes
//
//  Created by Trường Khoa on 07/05/2024.
//

import SwiftUI

struct MyNotesView: View {
    
    @EnvironmentObject var notesVM: NotesViewModel
    
    private let user:User
    @State private var presentingModal = false
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(self.notesVM.currentUser.notes) {
                    item in
                    NavigationLink("\(item.title)") {
                        DetailNoteView(detailNote: item)
                    }
                }
            }
            .navigationTitle("My Notes \(user.id)")

        }
        .toolbar {
            Button {
                self.presentingModal = true
            } label: {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $presentingModal, onDismiss: {
                self.notesVM.getNoteUser(user: self.user)
            }) {
                CreateNoteView(user: user)
            }

        }
        .onAppear() {
            self.notesVM.getNoteUser(user: self.user)
        }
    }
}

struct MyNotesView_Previews: PreviewProvider {
    static var previews: some View {
        MyNotesView(user: User(id: "", name: "", notes: []))
    }
}
