//
//  AddNoteView.swift
//  HoangAnhNotes
//
//  Created by Hoang Anh on 23/11/2023.
//

import SwiftUI

struct AddNoteView: View {
    @StateObject private var viewModel = AddNoteViewModel()
    @State private var content = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Text(viewModel.currentDateString)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextEditor(text: $content)
                .disableAutocorrection(true)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding(.horizontal, 10)
                .padding(.bottom, 30)
//                .background(Color.black.opacity(0.08))
                .shadow(radius: 9)
                .foregroundColor(Color.gray)
            
            Button {
                viewModel.saveNote(content: content)
                content = ""
                dismiss()
            } label: {
                Text("Save To Your Notes List")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.vertical, 10)
                    .frame(minWidth: 0, maxWidth: .infinity,minHeight: 50, maxHeight: 50)
                    .background(content.isEmpty ? Color.gray : Color.purple)
                    .cornerRadius(80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 80)
                            .stroke(Color.black, lineWidth: 0.5)
                    )
            }
            .padding(.horizontal,20)
            .disabled(content.isEmpty)
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(
                stops: [
                    Gradient.Stop(color: .white, location: 0.00),
                    Gradient.Stop(color: Color(red:0.88, green: 0.89, blue: 0.99), location: 1.00)
                ]
            ), startPoint: .top , endPoint: .bottom )
        )
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
