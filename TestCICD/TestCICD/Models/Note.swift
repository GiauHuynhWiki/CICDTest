//
//  Content.swift
//  HoangAnhNotes
//
//  Created by Hoang Anh on 23/11/2023.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: String
    let content: String
    let date: String
    
    init(id: String, content: String, date: String) {
        self.id = id
        self.content = content
        self.date = date
    }
    
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
