//
//  NoteListView.swift
//  HoangAnhNotes
//
//  Created by Hoang Anh on 24/11/2023.
//

import SwiftUI

struct NoteListView: View {
    @StateObject private var viewModel = NoteListViewModel()
    
    var body: some View {
        NavigationView {
            content
        }
        .accentColor(.black)
    }
    
    private var content: some View {
        VStack {
            if !viewModel.noteList.isEmpty {
                List {
                    ForEach(viewModel.noteList.indices.reversed(), id: \.self) { index in
                        let note = viewModel.noteList[index]
                        noteItem(note)
                            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive, action: {
                                    viewModel.deleteNote(note)
                                }, label: {
                                    Label("Delete", systemImage: "trash")
                                })
                            }
                    }
                }
            }
        }
        .navigationBarTitle("My Note List", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddNoteView()) {
                    HStack(spacing: 3){
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 17, height: 17)
                            .foregroundColor(Color.purple)
                            .padding()
                    }
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(
                stops: [
                    Gradient.Stop(color: .white, location: 0.00),
                    Gradient.Stop(color: Color(red:0.88, green: 0.89, blue: 0.99), location: 1.00)
                ]
            ), startPoint: .top, endPoint: .bottom )
        )
        .onAppear {
            viewModel.getNoteList()
        }
    }
        
    private func noteItem(_ note: Note) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.date)
                .font(.system(size: 15))
                .frame(alignment: .leading)
                .padding(.leading, 5)
            
            Text(note.content)
                .font(.system(size: 15))
                .foregroundColor(Color(red:0.43, green: 0.46, blue: 0.57))
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 8))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(Color.white)
                .cornerRadius(10)
                .lineLimit(nil)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
    }
}
