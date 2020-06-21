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
    let db = Firestore.firestore()
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
        db.collection("Tasks").addDocument(data: [
            "title": task.title,
            "date": task.date,
            "content": task.content,
            "status": task.status
        ])
    }
    
    func getData(from data: [Task]) {
        tasks = data
    }
    func printData() {
//        print("")
        for task in self.tasks {
            print(task)
        }
    }

    func getDataFromFirebase() {
        tasks = []
        db.collection("Tasks").getDocuments { (query, eeror) -> Void in
            if let query = query {
                for task in query.documents {
                    //                    print(task.data()["date"])
                    let item = Task(id: task.documentID ,title: task.data()["title"] as! String, content: task.data()["content"] as! String, date: task.data()["date"] as! String, status: task.data()["status"] as! Bool)
                    self.tasks += [item]
                }
            }
        }
    }
    
    func toggleTaskStatus(key: String) {
        let task = db.collection("Tasks").document(key)
        task.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() {
                    let status = !(data["status"] as! Bool)
                    task.updateData(["status": status])
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateData(key: String, field: String, value: String) {
        let task = db.collection("Tasks").document(key)
        task.getDocument { (document, error) in
            if let document = document, document.exists {
                task.updateData([field: value])
                print(document.data()!)
            } else {
                print("Document does not exist")
            }
        }
        getDataFromFirebase()
        printData()
        
    }
    
    func deleteAllData(){
        db.deleteEveryDocument()
    }
    
    func getDummyData() {
        addTask(from: Task(title: "HW1", content: "QQ", date: "2020/06/12 04:00", status: false))
        addTask(from: Task(title: "HW2", content: "aslkjfajfsjklasf", date: "2020/06/12 05:00", status: true))
        addTask(from: Task(title: "HW3", content: "aslkjfajfsjklasf", date: "2020/06/24 00:00", status: true))
        addTask(from: Task(title: "HW4", content: "aslkjfajfsjklasf", date: "2020/06/12 05:00"))
    }
    
    
    init() {
        getDataFromFirebase()
//        updateData(key:"6IelLfE78YwE7mpz0DQL", field: "date", value: "2020/06/09 00:00")
//        deleteAllData()

//        getDummyData()
    }
    
    
    
}
extension Firestore {
    func deleteEveryDocument() {
        collection("Tasks").getDocuments { (query, eeror) in
            if let query = query {
                for task in query.documents {
                    self.collection("Tasks").document(task.documentID).delete()
                }
            }
        }
    }
    

    
}
