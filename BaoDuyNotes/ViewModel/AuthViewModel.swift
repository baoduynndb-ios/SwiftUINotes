//
//  AuthViewModel.swift
//  BaoDuyNotes
//
//  Created by Trường Khoa on 07/05/2024.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseCore

class AuthViewModel: ObservableObject {
    
    @Published var userSignedIn: Bool = false
    
    let auth = Auth.auth()
    
    func isUserSignedIn() {
        let result = auth.currentUser != nil
        DispatchQueue.main.async {
            [weak self] in
            self?.userSignedIn = result
        }
    }
    
    //SignUp
    
    func signUpAccount(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) {
            [weak self] result, error in
            
            guard error == nil else {
                print("baonnd: signUp Error: \(String(describing: error))")
                return
            }
            
            guard let userEmail = result?.user.email else {
                print("baonnd: signUp result?.user.email error")
                return
            }
            
            print("baonnd: signUp email: \(userEmail)")
            self?.isUserSignedIn()
            
        }
    }
    
    //SignIn
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) {
            [weak self] result, error in
            
            guard error == nil else {
                print("baonnd: signIn Error: \(String(describing: error))")
                return
            }
            
            guard let userEmail = result?.user.email else {
                print("baonnd: signIn result?.user.email error")
                return
            }
            
            print("baonnd: signIn email: \(userEmail)")
            
            self?.isUserSignedIn()
        }
    }
    
}
