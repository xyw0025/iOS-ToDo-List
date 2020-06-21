//
//  TaskArchive.swift
//  ToDoList
//
//  Created by WEN on 2020/6/20.
//  Copyright © 2020 tina. All rights reserved.
//

import Foundation
import Firebase
import Dispatch
class TaskArchive {
    
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
    
    func addTask(from task: Task) {
        let db = Firestore.firestore()
        db.collection("Tasks").addDocument(data: [
            "title": task.title,
            "date": task.date,
            "content": task.content
        ])
    }
    
    func getData(from data: [Task]) {
        tasks = data
    }
    func printData() {
        print(tasks.count)
        for task in self.tasks {
            print(task)
        }
    }

    func getDataFromFirebase() {
        let db = Firestore.firestore()
        db.collection("Tasks").getDocuments { (query, eeror) -> Void in
            if let query = query {
                for task in query.documents {
                    //                    print(task.data()["date"])
                    let item = Task(title: task.data()["title"] as! String, content: task.data()["content"] as! String, date: task.data()["date"] as! String)
                    self.tasks += [item]
                }
            }
        }
    }
    init() {
        getDataFromFirebase()
    }
}
