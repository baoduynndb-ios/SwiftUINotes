//
//  CreateNoteView.swift
//  BaoDuyNotes
//
//  Created by Trường Khoa on 08/05/2024.
//

import SwiftUI
import AlertToast

struct CreateNoteView: View {
    
    @EnvironmentObject var notesVM: NotesViewModel
    private let user: User
    @State private var title = ""
    @State private var content = ""
    @Environment(\.dismiss) private var dismiss

    init(user:User) {
        self.user = user
    }

    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    TextField("Title", text: $title)
                        .foregroundColor(.black)
                        .padding([.trailing, .leading, .top], 10)
                        .listRowSeparator(.hidden)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                    ZStack {
                        TextEditor(text: $content)
                        Text(content).opacity(0)
                            .padding(.all, 10)
                    }
                    .border(.black)
                    .padding([.bottom, .leading, .trailing], 12)
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        Spacer()
                        Button {
                            self.notesVM.createNote(user: user, title: title, content: content)
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                dismiss()
                            }
                        } label: {
                            Text("Create")
                                .bold()
                                .frame(width: 200, height: 40, alignment: .center)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.linearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottomTrailing))
                                )
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding()
                    .listRowSeparator(.hidden)
                    
                }

            }
            .navigationTitle("Create New Note")
        }

    }
}

struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView(user: User(id: "", name: "", notes: []))
    }
}
