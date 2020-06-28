//
//  TaskContentPageItem.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/27.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit
import BLTNBoard

class TaskContentPageItem: BasePageBLTNItem, isAbleToReceiveData {
    
    init(id: String, t: Task) {
        super.init()
        self.taskID = id
        self.task = t
//        self.titleString = titleString
//        self.titleLabel.label.text = titleString
    }

    var task = Task(title: "", date: "")
    var taskID: String = ""
    var titleString = ""

    @objc public var textInputHandler: ((BLTNActionItem, String?) -> Void)? = nil


    @objc public var titleField: UITextField!
    @objc var dateField: UITextField!

    @objc public var contentField: UITextField!
    @objc public var tagsField: UITextField!
    var titleLbl: BLTNTitleLabelContainer!

    override func makeHeaderViews(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        titleLbl = interfaceBuilder.makeTitleLabel()
        titleLbl.label.text = task.title
        titleLbl.label.textColor = .black
        return [titleLbl]
    }
    override func makeViewsUnderTitle(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        titleField = interfaceBuilder.makeTextField(placeholder: taskID, returnKey: .done, delegate: self)
        dateField = interfaceBuilder.makeTextField(placeholder: "Date", returnKey: .done, delegate: self)
        contentField = interfaceBuilder.makeTextField(placeholder: "Content", returnKey: .done, delegate: self)
        tagsField = interfaceBuilder.makeTextField(placeholder: "tagsField", returnKey: .done, delegate: self)

        dateField.addTarget(self, action: #selector(clickedTextField), for: .touchDown)
        dateField.delegate = self

        configureTextFields()
        return [titleField, dateField, contentField]
    }


//    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
//    }
    @objc func clickedTextField() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "timepicker") as! CalendarPickerViewController
        vc.delegate = self
        manager?.present(vc, animated: true)
    }
    func pass(data: String) {
        dateField.text = data
    }
    func configureTextFields() {
        titleField.setText(text: task.title)
        dateField.setText(text: task.date)
        contentField.setText(text: task.content)
        titleField.configure()
        contentField.configure()
        tagsField.configure()
        dateField.configure()
    }
    override func tearDown() {
        super.tearDown()
//        datePicker.date = Date()
        dateField?.delegate = nil
        contentField?.delegate = nil
        tagsField?.delegate = nil
    }

    func setNewData() {
        if titleField.text != "" {
            task.title = titleField.text!
        }
        if dateField.text != "" {
            task.date = dateField.text!
        }
        if contentField.text != "" {
            task.content = contentField.text!
        }
//        print("testttt: \(titleField.text!)")
//        print("task title: \(task.title), task.content: \(task.content), task.date: \(task.date)")
    }
    override func actionButtonTapped(sender: UIButton) {
        setNewData()
        titleField.resignFirstResponder()
        super.actionButtonTapped(sender: sender)
    }
}

extension TaskContentPageItem: UITextFieldDelegate {

    @objc open func isInputValid(text: String?) -> Bool {

        if text == nil || text!.isEmpty {
            return false
        }

        return true

    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectedTextRange = textField.textRange(from: textField.endOfDocument, to: textField.endOfDocument)

    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.titleField {
            if isInputValid(text: textField.text) {
                textInputHandler?(self, textField.text)
            } else {
                descriptionLabel!.textColor = .red
                descriptionLabel!.text = "You must enter some text to be task title."
                textField.backgroundColor = UIColor.red.withAlphaComponent(0.3)
            }
        }
    }

}


extension UITextField {
    func configure() {
        self.borderStyle = .none
        self.backgroundColor = UIColor.clear
    }

    func setText(text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
}
