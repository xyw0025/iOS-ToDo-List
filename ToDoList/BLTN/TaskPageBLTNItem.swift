//
//  TaskPageBLTNItem.swift
//  TableTest
//
//  Created by Wen Hsin-Yu on 2020/6/27.
//  Copyright © 2020 WEN. All rights reserved.
//

import UIKit
import BLTNBoard

class TaskPageBLTNItem: BasePageBLTNItem {
//    override func actionButtonTapped(sender: UIButton) {
//        feed
//    }


    @objc public var titleField: UITextField!
    lazy var datePicker = UIDatePicker()
    @objc public var contentField: UITextField!
    @objc public var tagsField: UITextField!


    @objc public var textInputHandler: ((BLTNActionItem, String?) -> Void)? = nil

    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        titleField = interfaceBuilder.makeTextField(placeholder: "task title", returnKey: .done, delegate: self)
        datePicker.datePickerMode = .dateAndTime
//        dateField = interfaceBuilder.makeTextField(placeholder: "date", returnKey: .done, delegate: self)
        contentField = interfaceBuilder.makeTextField(placeholder: "content", returnKey: .done, delegate: self)
        tagsField = interfaceBuilder.makeTextField(placeholder: "tagsField", returnKey: .done, delegate: self)


        return [titleField, datePicker, contentField, tagsField]
    }

    override func tearDown() {
        super.tearDown()
        datePicker.date = Date()
        contentField?.delegate = nil
        tagsField?.delegate = nil
        titleField?.delegate = nil
    }

    override func actionButtonTapped(sender: UIButton) {
        titleField.resignFirstResponder()
        super.actionButtonTapped(sender: sender)
    }
}

extension TaskPageBLTNItem: UITextFieldDelegate {

//    @objc open func isInputValid(text: String?) -> Bool {
//
//        if text == nil || text!.isEmpty {
//            return false
//        }
//
//        return true
//
//    }

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


class BasePageBLTNItem: BLTNPageItem {
    private let feedbackGenerator = SelectionFeedbackGenerator()

    override func actionButtonTapped(sender: UIButton) {

        // Play an haptic feedback

        feedbackGenerator.prepare()
        feedbackGenerator.selectionChanged()

        // Call super

        super.actionButtonTapped(sender: sender)

    }

    override func alternativeButtonTapped(sender: UIButton) {

        // Play an haptic feedback

        feedbackGenerator.prepare()
        feedbackGenerator.selectionChanged()

        // Call super

        super.alternativeButtonTapped(sender: sender)

    }

}
