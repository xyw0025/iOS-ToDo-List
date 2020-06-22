//
//  addTaskField.swift
//  ToDoList
//
//  Created by WEN on 2020/6/22.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit

class addTaskField: UITextField, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
