//
//  FirebaseDatabase.swift
//  HoangAnhNotes
//
//  Created by Hoang Anh on 25/11/2023.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

protocol FirebaseDatabaseProtocol {
    func getNoteList(completion: @escaping ([Note]) -> Void)
    func saveNote(content: String, date: String)
    func deleteNote(withId noteId: String)
}

class FirebaseDatabase: FirebaseDatabaseProtocol {
    static let shared = FirebaseDatabase()
    private init() {}
    
    private let ref = Database.database().reference()
    
    // MARK: Notes
    func getNoteList(completion: @escaping ([Note]) -> Void) {
        let notesRef = ref.child("notes")
        notesRef.observe(.value) { parentSnapshot in
            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            let noteList = children.compactMap({ snapshot in
                return try? snapshot.data(as: Note.self)
            })
            completion(noteList)
        }
    }
    
    func saveNote(content: String, date: String) {
        let notesRef = ref.child("notes")
        let childRef = notesRef.childByAutoId()
        let id = childRef.key ?? ""
        let note = Note(id: id, content: content, date: date)
        
        childRef.setValue(note.toDictionary)
    }
    
    func deleteNote(withId noteId: String) {
        let noteRef = ref.child("notes").child(noteId)
        noteRef.removeValue { error, _ in
            if let error = error {
                print("Error deleting note: \(error.localizedDescription)")
            } else {
                print("Note deleted successfully")
            }
        }
    }
}
