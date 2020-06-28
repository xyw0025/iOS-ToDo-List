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
    var taskDates = Set<String>()
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
    func getAllDates() {
        let formatterWanted = DateFormatter()
        formatterWanted.dateFormat = "yyyy-MM-dd"
        taskDates = []
        for task in tasks {
            taskDates.insert(task.date.stringToDate().dateToString())
        }
//        print("taskDates:\(taskDates)")
    }
    func addTask(from task: Task) {
        db.collection("Tasks").addDocument(data: [
            "title": task.title,
            "date": task.date,
            "content": task.content,
            "status": task.status,
            "tags": task.tags
//            "timeStamp": task.timeStamp
        ])
    }

    func addDumbTask(from text: String) {
        addTask(from: Task(title: text, content: "...", date: "2020-06-22 06:23"))
    }

    func removeTask(for id: String) {
        db.collection("Tasks").document(id).delete()
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

    func toggleTaskStatus(key: String) {
        let task = db.collection("Tasks").document(key)
        task.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data(), document.documentID == key {
                    let status = !(data["status"] as! Bool)
                    task.updateData(["status": status])
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateDataDocument(key: String, field: String, value: String) {
        let task = db.collection("Tasks").document(key)
        task.getDocument { (document, error) in
            if let document = document, document.exists {
                task.updateData([field: value])
                print(document.data()!)
            } else {
                print("Document does not exist")
            }
        }        
    }

    func updateAllData(data: Task) {
        let task = db.collection("Tasks").document(data.id)
        task.updateData(["title": data.title, "content": data.content, "date": data.date, "tags": data.tags])
    }
    
    func deleteAllData(){
        db.deleteEveryDocument()
    }
    
    func getDummyData() {
        addTask(from: Task(title: "HW1", content: "QQ", date: "2020-06-12 04:00", status: false, tags: ["school", "通識"]))
        addTask(from: Task(title: "HW2", content: "aslkjfajfsjklasf", date: "2020-06-30 05:00", status: true, tags: ["school", "CS"]))
        addTask(from: Task(title: "HW3", content: "aslkjfajfsjklasf", date: "2020-06-24 00:00", status: true, tags: ["school"]))
        addTask(from: Task(title: "HW4", content: "aslkjfajfsjklasf", date: "2020-06-01 05:00", tags: ["school"]))
    }
    
    
    
    init() {
//        getDataFromFirebase()
//        print(".....")
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
