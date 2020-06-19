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

    var tasks = Tasks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderSideMenu()
        dailyTasks = getDummyData()
        tasks.getData(from: dailyTasks)
        calendar.delegate = self
        calendar.customizeCalenderAppearance()
        configureTableView()
        setTableViewDelegates()
    }
    func renderSideMenu() {
//        navigationController?.hideNavigationItemBackground()
//        view.backgroundColor = .white
//        self.navigationController?.isNavigationBarHidden = true
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
//        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.statusBarEndAlpha = 0
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    func configureTableView() {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine

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
//        print("selected: \(date)")
        let formatterWanted = DateFormatter()
        formatterWanted.dateFormat = "yyyy/MM/dd"
        if let selectedDate = formatterWanted.date(from: date.dateToString()) {
            print(tasks.findSelectedDateEvents(on: selectedDate))
        } else {
            print("error")
        }
        
        // find events only on that selected date
    }
// class TASKS


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
    var date: String
}


extension CalendarViewController {
//    隨便生ㄉdata
    func getDummyData()-> [Task]{
        let day1 = Task(title: "HW1", content: "寫完作業...", date: "2020/06/12 03:31")
        let day2 = Task(title: "HW2", content: "寫完作業?..", date: "2020/06/24 22:31")
        return [day1, day2]
    }
}


class Tasks {
    var tasks = [Task]()
    
    func findSelectedDateEvents(on date: Date) -> [Task] {
        var eventsOnDate = [Task]()
        for task in tasks {
            if date.isSameDay(comparedDate: task.date.stringToDate()) {
//                print(date.dateToString() + "\n" + task.date)
                eventsOnDate += [task]
            }
        }
        return eventsOnDate
    }
    func getData(from data: [Task]) {
        tasks = data
    }
}
// TODO: date declaration
// TODO: clean renderSideMenu
extension Date {
    func isSameDay(comparedDate: Date) -> Bool {
//        let diff = Calendar.current.dateComponents([.day], from: self, to: comparedDate)
//        print("diff \(diff)")
        if self == comparedDate {
            return true
        } else {
            return false
        }
    }
    
    func dateToString() -> String {
        var dateString = ""
        let renderedFormatter = DateFormatter()
        renderedFormatter.dateFormat = "yyyy/MM/dd"
        dateString = renderedFormatter.string(from: self)
        return dateString
    }
}
extension String {
    func stringToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let dateString = String(self[..<self.firstIndex(of: " ")!])
        let date = formatter.date(from: dateString)
        return date ?? formatter.date(from: "1997/11/04")!
    }
}
