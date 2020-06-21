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
import Firebase


class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    @IBOutlet var calendar: FSCalendar!
    var tableView = UITableView()
    var dailyTasks = [Task]() {
        didSet {
            // refresh the table
            tableView.reloadData()
        }
    }
    var menu: SideMenuNavigationController?
    var tasks = TaskArchive()
    
    var datesWithEvent = ["2020-06-03"]

    
    
    func test() {

        tasks.updateData(key: "7ETvKlH52z8VWHNWUr0T", field: "date", value: "2020/06/01 00:00")
        tasks.printData()
        //let task1 = Task(title: "testtest0000", content: "afakjsfkajlsf", date: "2020/06/28")
//        tasks.addTask(from: task1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        renderSideMenu()
        
        dailyTasks = tasks.findSelectedDateEvents(on: Date())
        // print current date
        
//        test()
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.customizeCalenderAppearance()
        configureTableView()
        setTableViewDelegates()
        
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
        print("selected: \(date)")
        let formatterWanted = DateFormatter()
        formatterWanted.dateFormat = "yyyy/MM/dd"
        if let selectedDate = formatterWanted.date(from: date.dateToString()) {
            print(tasks.findSelectedDateEvents(on: selectedDate))
            dailyTasks = tasks.findSelectedDateEvents(on: selectedDate)
        } else {
            print("error")
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatterWanted = DateFormatter()
        formatterWanted.dateFormat = "yyyy-MM-dd"

        let dateString = formatterWanted.string(from: date)

        if self.datesWithEvent.contains(dateString) {
            return 1
        }

        return 0
    }
    func renderSideMenu() {
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.statusBarEndAlpha = 0
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
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

        tableView.deselectRow(at: indexPath, animated: false)
        print(",,,,")
        

    }
}



extension CalendarViewController {
//    隨便生ㄉdata
    func getDummyData()-> [Task]{
        let day1 = Task(title: "HW1", content: "寫完作業...", date: "2020/06/12 03:31")
        let day2 = Task(title: "HW2", content: "寫完作業?..", date: "2020/06/24 22:31")
        return [day1, day2]
    }
    
}







