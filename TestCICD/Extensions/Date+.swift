//
//  Date+.swift
//  HoangAnhNotes
//
//  Created by Hoang Anh on 25/11/2023.
//

import Foundation

extension Date {
    static var currentDateString: String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: currentDate)
    }
}
