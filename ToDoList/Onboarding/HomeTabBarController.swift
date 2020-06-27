//
//  HomeTabBarController.swift
//  ToDoList
//
//  Created by tina on 2020/6/23.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {
    func changeSelectedIndex(to index: Int) {
        selectedIndex = index
    }

    

    var taskArchive = TaskArchive()




    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for calendar")

        let controller = segue.destination as? UITabBarController
        let calendar = controller?.viewControllers?[2] as! CalendarViewController
        calendar.checkForUpdates()
//        calendar.getDataFromFirebase()
        calendar.calendar.reloadData()



    }
}



