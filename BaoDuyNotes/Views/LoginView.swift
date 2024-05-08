//
//  LoginView.swift
//  BaoDuyNotes
//
//  Created by Trường Khoa on 07/05/2024.
//

import SwiftUI
import AlertToast

struct LoginView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isShowToast = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.blue,.green], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            VStack {
                Text("My Notes")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .padding([.trailing, .leading], 40)
                    .disableAutocorrection(true)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white)
                    .padding([.trailing, .leading], 40)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .padding([.trailing, .leading], 40)
                    .padding(.top, 20)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white)
                    .padding([.trailing, .leading], 40)
                
                Button {
                    if email.isEmpty || password.isEmpty {
                        isShowToast = true
                        return
                    }
                    authVM.signUpAccount(email: email, password: password)
                } label: {
                    Text("Sign up")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing))
                        )
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
                
                Button {
                    if email.isEmpty || password.isEmpty {
                        isShowToast = true
                        return
                    }
                    authVM.signIn(email: email, password: password)
                } label: {
                    Text("Already have an account? Login")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
                
            }
            .toast(isPresenting: $isShowToast, duration: 2, tapToDismiss: false) {
                let toast = email.isEmpty ? "Email" : "Password"
                return AlertToast(displayMode: .hud, type: .error(.red), title: "Please fill \(toast)")
            }
        }
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
