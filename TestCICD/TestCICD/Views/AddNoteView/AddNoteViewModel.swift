//
//  AddNoteViewModel.swift
//  HoangAnhNotes
//
//  Created by Hoang Anh on 23/11/2023.
//

import Foundation

class AddNoteViewModel: ObservableObject {
    private let firebaseDatabase: FirebaseDatabaseProtocol
    let currentDateString = Date.currentDateString

    init(firebaseDatabase: FirebaseDatabaseProtocol = FirebaseDatabase.shared) {
        self.firebaseDatabase = firebaseDatabase
    }

    func saveNote(content: String) {
        firebaseDatabase.saveNote(content: content, date: currentDateString)
    }
}
