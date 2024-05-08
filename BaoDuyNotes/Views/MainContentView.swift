//
//  HomeView.swift
//  BaoDuyNotes
//
//  Created by Trường Khoa on 07/05/2024.
//

import SwiftUI
import TabBar

enum Item: Int, Tabbable {
    case allNote = 0
    case myNote
    
    var icon: String {
        switch self {
            case .allNote:
                return "house"
            case .myNote:
                return "person"
        }
    }
    
    var title: String {
        switch self {
            case .allNote:
                return "All Notes"
            case .myNote:
                return "My Notes"
        }
    }
}

struct MainContentView: View {
    
    @EnvironmentObject var notesVM: NotesViewModel
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var selection: Item = .allNote
    @State private var visibility: TabBarVisibility = .visible

    var body: some View {
        TabBar(selection: $selection, visibility: $visibility) {
            
            AllNotesView()
                .tabItem(for: Item.allNote)
            
            MyNotesView(user: User(id: authVM.auth.currentUser?.uid ??
                                   "", name: authVM.auth.currentUser?.email ?? "", notes: []))
                .tabItem(for: Item.myNote)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
