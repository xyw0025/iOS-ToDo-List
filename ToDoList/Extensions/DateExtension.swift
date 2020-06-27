//
//  DateExtension.swift
//  ToDoList
//
//  Created by WEN on 2020/6/20.
//  Copyright © 2020 tina. All rights reserved.
//

import Foundation
extension Date {
    func isSameDay(comparedDate: Date) -> Bool {
        if self == comparedDate {
            return true
        } else {
            return false
        }
    }
    
    func dateToString() -> String {
        var dateString = ""
        let renderedFormatter = DateFormatter()
        renderedFormatter.dateFormat = "yyyy-MM-dd"
        dateString = renderedFormatter.string(from: self)
        return dateString
    }

    func dateAndTimeToString() -> String {
        var dateString = ""
        let renderedFormatter = DateFormatter()
        renderedFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateString = renderedFormatter.string(from: self)
        return dateString
    }
}
