//
//  FSCalendarExtensions.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/17.
//  Copyright © 2020 tina. All rights reserved.
//

import Foundation
import FSCalendar
extension FSCalendar {
    func customizeCalenderAppearance() {
        self.backgroundColor = UIColor.LightMode.calendarBackground
        self.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        self.appearance.eventDefaultColor    = UIColor.Calendar.eventDefaultColor
        self.appearance.eventSelectionColor = UIColor.Calendar.eventSelectionColor
        self.appearance.eventOffset = self.eventOffsetPos
        self.appearance.headerTitleColor = UIColor.Calendar.headerTitleColor
        self.appearance.todayColor           = UIColor.Calendar.today
        self.appearance.headerMinimumDissolvedAlpha = 0.0 // Hide Left Right Month Name
    }


    var eventOffsetPos: CGPoint { return CGPoint(x: 0, y: -12)}




}
//        self.appearance.headerTitleFont      = UIFont.init(name: Fonts.BalloRegular, size: 18)
//        self.appearance.weekdayFont          = UIFont.init(name: Fonts.RalewayRegular, size: 16)
//        self.appearance.titleFont            = UIFont.init(name: Fonts.RalewayRegular, size: 16)
//        self.appearance.headerTitleColor     =
//        self.appearance.weekdayTextColor     = Colors.topTabBarSelectedColor
//        self.appearance.selectionColor       =
//        self.appearance.titleSelectionColor  = Colors.NavTitleColor
//      self.appearance.todaySelectionColor  = Colors.purpleColor
