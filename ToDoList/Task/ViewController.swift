//
//  ViewController.swift
//  ToDoList
//
//  Created by tina on 2020/6/13.
//  Copyright © 2020 tina. All rights reserved.
//
import SideMenu
import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var menu: SideMenuNavigationController?
    var taskArchive = TaskArchive()
    let db = Firestore.firestore()


    var button = AddTaskButton()
      override func viewDidLoad() {
        super.viewDidLoad()
        if isDarkMode() {print("isDarkMode")} else {
//            print("isntDarkMode")
        }
        renderSideMenu()
        button.configureButton(to: view)
        checkForUpdates()
        configureTableView()

      }
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(DailyTaskCell.self, forCellReuseIdentifier: "DailyTaskCell")
    }
    func getDataFromFirebase() {
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
                self.tableView.reloadData()
            }
        }
    }
    
    func checkForUpdates() {
        db.collection("Tasks").order(by: "date").addSnapshotListener {
            querySnapshot, error in
            self.getDataFromFirebase()
        }
    }
    
    
    
    



    override func viewWillAppear(_ animated: Bool) {
        let tabBar = tabBarController as! HomeTabBarController
        taskArchive = tabBar.taskArchive
    }

    
    func renderSideMenu() {
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = false

        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.statusBarEndAlpha = 0
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)

    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArchive.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyTaskCell") as! DailyTaskCell
        cell.selectionStyle = .none
        let task = taskArchive.tasks[indexPath.row]
        cell.setTask(to: task)
        return cell
    }
}

extension UIViewController {
    func isDarkMode() -> Bool {
        switch traitCollection.userInterfaceStyle {
        case .light: return false
        case .dark: return true
        case .unspecified: return false
        @unknown default:
            return false
        }
    }
}
