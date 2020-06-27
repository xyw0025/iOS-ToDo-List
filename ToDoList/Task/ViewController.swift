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
import BLTNBoard

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var menu: SideMenuNavigationController?
    var taskArchive = TaskArchive()
    let db = Firestore.firestore()

    let page = BLTNDataSource.makeTextFieldPage()
    lazy var addingTaskBoardManager = BLTNItemManager(rootItem: page)



    var button = AddTaskButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        if isDarkMode() {print("isDarkMode")} else {
            //            print("isntDarkMode")
        }
        renderSideMenu()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        button.configureButton(to: view)
        checkForUpdates()
        configureTableView()
        configureBLTN()
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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }

    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let deleteTask = self.taskArchive.tasks[indexPath.row]
            self.taskArchive.removeTask(for: deleteTask.id)
            completion(true)
        }
        action.image = UIImage(systemName: "trash")
        action.backgroundColor = .red


        return action
    }
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


