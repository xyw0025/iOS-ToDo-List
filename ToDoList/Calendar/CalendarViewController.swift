//
//  CalendarViewController.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/16.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit
import FSCalendar
import SideMenu

class CalendarViewController: UIViewController, FSCalendarDelegate {
    @IBOutlet var calendar: FSCalendar!
    var tableView = UITableView()
    var dailyTasks = [Task]()
    var menu: SideMenuNavigationController?


    override func viewDidLoad() {
        super.viewDidLoad()
        renderSideMenu()
        dailyTasks = getDummyData()
        calendar.delegate = self
        calendar.customizeCalenderAppearance()
        configureTableView()
        setTableViewDelegates()
    }
    func renderSideMenu() {
        navigationController?.hideNavigationItemBackground()
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.statusBarEndAlpha = 0
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(DailyTaskCell.self, forCellReuseIdentifier: "DailyTaskCell")
        tableView.pinOver(to: view, below: calendar)
    }
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("selected: \(date)")
    }



}
extension FSCalendar {
    func customizeCalenderAppearance() {
        self.backgroundColor = .white
        self.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]

//        self.appearance.headerTitleFont      = UIFont.init(name: Fonts.BalloRegular, size: 18)
//        self.appearance.weekdayFont          = UIFont.init(name: Fonts.RalewayRegular, size: 16)
//        self.appearance.titleFont            = UIFont.init(name: Fonts.RalewayRegular, size: 16)

//        self.appearance.headerTitleColor     =
////        self.appearance.weekdayTextColor     = Colors.topTabBarSelectedColor
//        self.appearance.eventDefaultColor    =
//        self.appearance.selectionColor       =
////        self.appearance.titleSelectionColor  = Colors.NavTitleColor
//
//
//        self.appearance.todayColor           =
////        self.appearance.todaySelectionColor  = Colors.purpleColor
//
//        self.appearance.headerMinimumDissolvedAlpha = 0.0 // Hide Left Right Month Name
    }


}



extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyTasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyTaskCell") as! DailyTaskCell
        cell.selectionStyle = .none
        let day = dailyTasks[indexPath.row]
        cell.setTask(to: day)
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//            tableView.deselectRow(at: indexPath, animated: false)

    }
}

struct Task {
    var title: String
    var content: String
//    var date: date
    // TODO: data declaration
}

extension CalendarViewController {
//    隨便生ㄉdata
    func getDummyData()-> [Task]{
        let day1 = Task(title: "HW1", content: "寫完作業...")
        let day2 = Task(title: "HW2", content: "寫完作業?..")
        return [day1, day2]
    }
}
