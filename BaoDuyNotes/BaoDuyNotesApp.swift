//
//  BaoDuyNotesApp.swift
//  BaoDuyNotes
//
//  Created by Trường Khoa on 07/05/2024.
//

import SwiftUI
import Firebase

@main
struct BaoDuyNotesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var authVM = AuthViewModel()
    @StateObject var notesVM = NotesViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
                .environmentObject(notesVM)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("baonnd: FirebaseApp.configure()")
        return true
    }

}
