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


class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITextFieldDelegate {
    @IBOutlet var calendar: FSCalendar!
//    var addTaskTextField = UITextField()
    var tableView = UITableView()
    var dailyTasks = [Task]() {
        didSet {
            // refresh the table
            tableView.reloadData()
        }
    }
    @IBOutlet weak var addTaskField: UITextField!
    let db = Firestore.firestore()


    var menu: SideMenuNavigationController?
    var taskArchive = TaskArchive()
    
    var tasks = [Task]()

    @IBAction func addTask(_ sender: UITextField) {
        taskArchive.addTask(from: Task(title: sender.text!, content: "...", date: "2020-06-22 06:23"))
        print(sender.text)
        checkForUpdates()
    }
    
    func test() {

//        tasks.updateDataDocument(key: "i768Q999x8Q2r0QmwNOd", field: "content", value: "123")
//        tableView.reloadData()
        let task1 = Task(title: "00", content: "afakjsfkajlsf", date: "2020-06-28 05:22")
        taskArchive.addTask(from: task1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        renderSideMenu()
        
        dailyTasks = taskArchive.findSelectedDateEvents(on: Date())
        // print current date
        
        
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.customizeCalenderAppearance()
        configureTableView()
        configureCalendar()
        configureTextfield()
        setTableViewDelegates()
        
        checkForUpdates()
//        checkForUpdates()
//        test()
        
    }
    func checkForUpdates() {
//        db.collection("Tasks").addSnapshotListener { (querySnapshot, error) in
//            guard let snapshot = querySnapshot else {return}
//            snapshot.documentChanges.forEach { (diff) in
////                if diff.type == .modified, diff.type == .added, diff.type == .removed {
////                    DispatchQueue.main.async {
////                        self.tableView.reloadData()
////                    }
////                }
//                if diff.type == .added {
//                    self.taskArchive.getDataFromFirebase()
//                    self.tasks = self.taskArchive.tasks
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//        }
        
        self.taskArchive.getDataFromFirebase()
        self.tasks = self.taskArchive.tasks
//        DispatchQueue.main.async {
            self.tableView.reloadData()
//        }
//        print(self.tasks.tasks)
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
    
    func configureTextfield() {
        addTaskField.delegate = self
        
        tableView.addSubview(addTaskField)
        addTaskField.pin(to: tableView)

        tableView.bringSubviewToFront(addTaskField)
    
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    

    
    func configureCalendar() {
        taskArchive.getAllDates()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("selected: \(date)")
//        checkForUpdates()
        let formatterWanted = DateFormatter()
        formatterWanted.dateFormat = "yyyy-MM-dd"
        if let selectedDate = formatterWanted.date(from: date.dateToString()) {
            print(taskArchive.findSelectedDateEvents(on: selectedDate))
            dailyTasks = taskArchive.findSelectedDateEvents(on: selectedDate)
        } else {
            print("error")
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatterWanted = DateFormatter()
        formatterWanted.dateFormat = "yyyy-MM-dd"
        let dateString = formatterWanted.string(from: date)
        if taskArchive.taskDates.contains(dateString) {
            print("dateString:\(dateString)")
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

        tableView.deselectRow(at: indexPath, animated: true)
        print(",,,,")
        

    }
}



extension CalendarViewController {
//    隨便生ㄉdata
    func getDummyData()-> [Task]{
        let day1 = Task(title: "HW1", content: "寫完作業...", date: "2020-06-12 03:31")
        let day2 = Task(title: "HW2", content: "寫完作業?..", date: "2020-06-24 22:31")
        return [day1, day2]
    }
    
}







