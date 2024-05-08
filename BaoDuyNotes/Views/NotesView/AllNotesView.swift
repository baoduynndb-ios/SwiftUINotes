//
//  AllNotesView.swift
//  BaoDuyNotes
//
//  Created by Trường Khoa on 07/05/2024.
//

import SwiftUI

struct AllNotesView: View {
    
    @EnvironmentObject var notesVM: NotesViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List(self.notesVM.allUsers) {
                    item in
                    NavigationLink("\(item.name)") {
                        MyNotesView(user: item)
                    }
                }
            }
            .navigationTitle("All Notes")
            .onAppear() {
                self.notesVM.getAllUser()
            }
        }
    }
}

struct AllNotesView_Previews: PreviewProvider {
    static var previews: some View {
        AllNotesView()
    }
}
