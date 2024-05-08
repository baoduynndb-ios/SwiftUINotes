//
//  User.swift
//  BaoDuyNotes
//
//  Created by Trường Khoa on 07/05/2024.
//

import Foundation

struct User: Identifiable {
    var id: String
    var name: String
    var notes:[DetailNote]
}
