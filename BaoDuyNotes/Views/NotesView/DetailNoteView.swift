//
//  DetailNoteView.swift
//  BaoDuyNotes
//
//  Created by Trường Khoa on 08/05/2024.
//

import SwiftUI

struct DetailNoteView: View {
    
    private let detailNote: DetailNote
    
    init(detailNote: DetailNote) {
        self.detailNote = detailNote
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.blue,.green], startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack(alignment: .leading) {
                Text("\(self.detailNote.content)")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding([.leading, .top
                        , .trailing], 20)
            }
        }
        .navigationTitle(self.detailNote.title)
    }
}

struct DetailNoteView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNoteView(detailNote: DetailNote(id: "", title: "", content: ""))
    }
}
