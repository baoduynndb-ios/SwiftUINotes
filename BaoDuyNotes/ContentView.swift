//
//  ContentView.swift
//  BaoDuyNotes
//
//  Created by Trường Khoa on 07/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var notesVM: NotesViewModel
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        
        NavigationStack {
            if !authVM.userSignedIn {
                LoginView()
            } else {
                MainContentView()
            }
        }
        .environmentObject(authVM)
        .environmentObject(notesVM)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
