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
import BLTNBoard


class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITextFieldDelegate {
    @IBOutlet var calendar: FSCalendar!
    var tableView = UITableView()
    var dailyTasks = [Task]() {
        didSet {
            // refresh the table
            tableView.reloadData()
        }
    }
    var button = AddTaskButton()
    @IBOutlet weak var addTaskField: UITextField!
    let db = Firestore.firestore()

    var menu: SideMenuNavigationController?
    var taskArchive = TaskArchive()

    let page = BLTNDataSource.makeTextFieldPage()
    lazy var addingTaskBoardManager = BLTNItemManager(rootItem: page)


    @IBAction func addTask(_ sender: UITextField) {
        taskArchive.addTask(from: Task(title: sender.text!, content: "...", date: "2020-06-22 06:23"))
        sender.text = ""

        self.tableView.reloadData()
        self.calendar.reloadData()
    }


    func configureBLTN() {
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        page.actionHandler = { item in
            let date = self.page.datePicker.date
            if self.page.titleField.text != "" {
                self.taskArchive.addTask(from: Task(title: self.page.titleField.text ?? "new task", content: self.page.contentField.text ?? "", date:  date.dateAndTimeToString() , tags: [self.page.tagsField.text ?? ""]))
            }

            item.manager?.dismissBulletin(animated: true)
        }

    }
    @objc func buttonClicked(_ sender: UIButton) {
        addingTaskBoardManager.showBulletin(above: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForUpdates()

        renderSideMenu()
        configureBLTN()
        configureTableView()
        configureCalendar()
        button.configureButton(to: view)
        setTableViewDelegates()

//        taskArchive.deleteAllData()
//        taskArchive.getDummyData()
//        test()
        
    }

    func getDataFromFirebase() {
//        print("getting in ")
        db.collection("Tasks").order(by: "date").getDocuments() {
            querySnapshot, error in

            self.taskArchive.tasks = []
            if let querySnapshot = querySnapshot {
                for task in querySnapshot.documents {
                    let item = Task(id: task.documentID ,title: task.data()["title"] as! String, content: task.data()["content"] as! String, date: task.data()["date"] as! String, status: task.data()["status"] as! Bool, tags: task.data()["tags"] as! [String])
                    self.taskArchive.tasks += [item]
                }
                self.taskArchive.getAllDates()
                self.tableView.reloadData()


            }
            DispatchQueue.main.async {
//                print("GetDataFromFirebase")
                self.dailyTasks = self.findTasksOnDate(date: self.calendar?.selectedDate ?? Date())
                self.tableView.reloadData()
                self.calendar.reloadData()
            }
        }
    }

    func checkForUpdates() {
//        print("check for updates----------")
        db.collection("Tasks").order(by: "date").addSnapshotListener {
            querySnapshot, error in
            self.getDataFromFirebase()
        }
    }


    func configureCalendar() {
        let formatterWanted = DateFormatter()
        formatterWanted.dateFormat = "yyyy-MM-dd"
        let today = formatterWanted.date(from: Date().dateToString())
        dailyTasks = taskArchive.findSelectedDateEvents(on: today!)

        calendar.delegate = self
        calendar.dataSource = self

        calendar.customizeCalenderAppearance()
        taskArchive.getAllDates()
    }



    func configureTableView() {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine

        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.register(DailyTaskCell.self, forCellReuseIdentifier: "DailyTaskCell")
        tableView.pinOver(to: view, below: calendar)
        dailyTasks = taskArchive.findSelectedDateEvents(on: Date())
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
    
    func findTasksOnDate(date: Date) -> [Task]{
        let formatterWanted = DateFormatter()
        formatterWanted.dateFormat = "yyyy-MM-dd"
        if let selectedDate = formatterWanted.date(from: date.dateToString()) {
            dailyTasks = taskArchive.findSelectedDateEvents(on: selectedDate)
        }
        return dailyTasks
    }
    



    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        print("selected: \(date)")
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
            return 1
        }

        return 0
    }


    
    func renderSideMenu() {
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = false
        
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.statusBarEndAlpha = 0
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)

    }

}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }

    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let deleteTask = self.dailyTasks[indexPath.row]
            self.taskArchive.removeTask(for: deleteTask.id)
            self.dailyTasks.remove(at: indexPath.row)
            completion(true)
        }
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .red


        return action
    }

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

    }
}



extension CalendarViewController {
//    隨便生ㄉdata
    func getDummyData()-> [Task]{
        let day1 = Task(title: "HW1", content: "寫完作業...", date: "2020-06-12 03:31")
        let day2 = Task(title: "HW2", content: "寫完作業?..", date: "2020-06-24 22:31")
        return [day1, day2]
    }

    func test() {
        let task1 = Task(title: "00", content: "afakjsfkajlsf", date: "2020-06-28 05:22")
        taskArchive.addTask(from: task1)
    }


}





