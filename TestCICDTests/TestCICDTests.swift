//
//  TestCICDTests.swift
//  TestCICDTests
//
//  Created by Giau Huynh on 18/4/24.
//

import XCTest
@testable import TestCICD

class TestCICDTests: XCTestCase {
    private let firebaseDatabaseMock = FirebaseDatabaseMock()
    private var noteListViewModel: NoteListViewModel?
    private var addNoteViewModel: AddNoteViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        noteListViewModel = NoteListViewModel(firebaseDatabase: firebaseDatabaseMock)
        addNoteViewModel = AddNoteViewModel(firebaseDatabase: firebaseDatabaseMock)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        noteListViewModel = nil
        addNoteViewModel = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetNoteList() {
            // test initial count
            noteListViewModel?.getNoteList()
            var count = noteListViewModel?.noteList.count ?? 0
            XCTAssertEqual(firebaseDatabaseMock.noteList.count, count, "Count must equal!")
            
            // test after saved 2 items
            firebaseDatabaseMock.saveNote(content: "test content1", date: Date.currentDateString)
            firebaseDatabaseMock.saveNote(content: "test content2", date: Date.currentDateString)
            count += 2
            XCTAssertEqual(firebaseDatabaseMock.noteList.count, count, "After saved 2 items, count in database must equal!")
            
            noteListViewModel?.getNoteList()
            XCTAssertEqual(noteListViewModel?.noteList.count, count, "After saved 2 items, count in viewModel must equal!")
            
            // test after remove the second item
            firebaseDatabaseMock.noteList.remove(at: 1)
            count -= 1
            XCTAssertEqual(firebaseDatabaseMock.noteList.count, count, "After remove 1 item, count in database must equal!")
            
            noteListViewModel?.getNoteList()
            XCTAssertEqual(noteListViewModel?.noteList.count, count, "After remove 1 item, count in viewModel must equal!")
        }

        func testAddNote() {
            noteListViewModel?.getNoteList()
            let noteListCount = noteListViewModel?.noteList.count ?? 0
            
            // saveNote
            let content = "test content"
            addNoteViewModel?.saveNote(content: "test content")
            noteListViewModel?.getNoteList()
            
            // test some asserts to ensure recent note saved successfully
            XCTAssertEqual(noteListViewModel?.noteList.count, noteListCount + 1, "Count must equal!")
            XCTAssertEqual(noteListViewModel?.noteList.last?.content, content, "Content must equal!")
            XCTAssertEqual(noteListViewModel?.noteList.last?.date, addNoteViewModel?.currentDateString, "Date must equal!")
        }
        
        func testDeleteNote() {
//            let content = "test content"
            addNoteViewModel?.saveNote(content: "test content")
            
            // test recent added note exist
            let lastNote = firebaseDatabaseMock.noteList.last
            XCTAssertNotNil(lastNote, "Can't get recent added note!")
            
            // test recent note deleted successfully
            guard let lastNote = lastNote else { return }
            noteListViewModel?.deleteNote(lastNote)
            XCTAssertFalse(firebaseDatabaseMock.noteList.contains(where: { $0.id == lastNote.id }), "Recent deleted note still exist!")
        }

}

// MARK: FirebaseDatabaseMock
class FirebaseDatabaseMock: FirebaseDatabaseProtocol {
    var noteList: [Note] = []
    
    func getNoteList(completion: @escaping ([TestCICD.Note]) -> Void) {
        completion(noteList)
    }
    
    func saveNote(content: String, date: String) {
        let note = Note(id: UUID().uuidString, content: content, date: date)
        noteList.append(note)
    }
    
    func deleteNote(withId noteId: String) {
        noteList.removeAll(where: { $0.id == noteId })
    }
}
