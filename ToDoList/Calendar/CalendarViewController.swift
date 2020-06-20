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

class CalendarViewController: UIViewController, FSCalendarDelegate {
    @IBOutlet var calendar: FSCalendar!
    var tableView = UITableView()
    var dailyTasks = [Task]()
    var menu: SideMenuNavigationController?

    var tasks = TaskArchive()
    
    
    func test() {
        let task1 = Task(title: "testtest0000", content: "afakjsfkajlsf", date: "2020/06/28")
//        tasks.addTask(from: task1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderSideMenu()
        
        dailyTasks = getDataFromFirebase()
//        dailyTasks = getDummyData()
//        print(dailyTasks)
        tasks.getData(from: dailyTasks)
        
        calendar.delegate = self
        calendar.customizeCalenderAppearance()
        configureTableView()
        setTableViewDelegates()
        
        test()
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



extension CalendarViewController {
//    隨便生ㄉdata
    

    func getDummyData()-> [Task]{
        let day1 = Task(title: "HW1", content: "寫完作業...", date: "2020/06/12 03:31")
        let day2 = Task(title: "HW2", content: "寫完作業?..", date: "2020/06/24 22:31")
        return [day1, day2]
    }
    
    
    // MARK: 這邊拋出data有問題 所以上面的dailyTasks會是空的
    func getDataFromFirebase()-> [Task] {
            var data = [Task]()
    //        var item: Task
        let db = Firestore.firestore()
        
        db.collection("Tasks").getDocuments { (query, eeror) -> Void in
//            if let query = query {
//                for task in query.documents {
//    //                    print(task.data()["date"])
//                    let item = Task(title: task.data()["title"] as! String, content: task.data()["content"] as! String, date: task.data()["date"] as! String)
//                    data += [item]
//                }
//            }
        
                
        }
         return data
    }
}





// TODO: date declaration
// TODO: clean renderSideMenu
//
//if let url = URL(string: "https://dcard.tw/_api/posts/\(post.id)") {
//
//    print(post.id)
//
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//        let decoder = JSONDecoder()
//        let formatter = ISO8601DateFormatter()
//        //                解析時間ISO8601
//        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
//        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
//            let data = try decoder.singleValueContainer().decode(String.self)
//            //                    回傳接到的時間，否則回傳目前時間
//            return formatter.date(from: data) ?? Date()
//        })
//}
