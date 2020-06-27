//
//  BLTNDataSource.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/27.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit
import BLTNBoard

class BLTN: BLTNPageItem {

}
enum BLTNDataSource {
    static func makeTextFieldPage() -> TaskPageBLTNItem {
        let page = TaskPageBLTNItem(title: "Create New Task")
        page.isDismissable = true
        page.descriptionText = ""
        page.actionButtonTitle = "Create"

        //        page.textInputHandler = { (item, text) in
        //            print(page.tagsField)
        //            print("Text: \(text ?? "nil")")
        //            print(item)
        //        }

        return page
    }
}
