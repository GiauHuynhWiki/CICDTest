//
//  NoteListViewModel.swift
//  HoangAnhNotes
//
//  Created by Hoang Anh on 24/11/2023.
//

import Foundation

class NoteListViewModel: ObservableObject {
    private let firebaseDatabase: FirebaseDatabaseProtocol
    @Published var noteList: [Note] = []
    
    init(firebaseDatabase: FirebaseDatabaseProtocol = FirebaseDatabase.shared) {
        self.firebaseDatabase = firebaseDatabase
    }
    
    func getNoteList() {
        firebaseDatabase.getNoteList { noteList in
            self.noteList = noteList
        }
    }
    
    func deleteNote(_ note: Note) {
        firebaseDatabase.deleteNote(withId: note.id)
    }
}
