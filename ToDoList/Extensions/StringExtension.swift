//
//  StringExtension.swift
//  ToDoList
//
//  Created by WEN on 2020/6/20.
//  Copyright © 2020 tina. All rights reserved.
//

import Foundation

extension String {
    func stringToDate() -> Date {
        var dateString = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateString = String(self[..<self.firstIndex(of: " ")!])
        let date = formatter.date(from: dateString)
        return date ?? formatter.date(from: "1997-11-04")!
    }
}
