//
//  CalendarViewController.swift
//  TableTest
//
//  Created by Wen Hsin-Yu on 2020/6/28.
//  Copyright © 2020 WEN. All rights reserved.
//
import UIKit
import FSCalendar

class CalendarPickerViewController: UIViewController, FSCalendarDelegate {
//    let calendar = FSCalendar(frame: CGRect(x:0, y:0, width: 100, height: 100))
    var delegate: isAbleToReceiveData!
    @IBOutlet var calendar: FSCalendar!

    @IBAction func timePicker(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
//        print(formatter.string(from: sender.date))
        let time = formatter.string(from: sender.date)
        self.time = time
    }
    


    var date = String()
    var time = String()
    public var dateAndTime = String()

    func configureDateTime() {
        let currentDate = Date()
        let timeFormatter = DateFormatter()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_Hant_TW")
        dateFormatter.dateFormat = "YYYY-MM-dd"
        timeFormatter.locale = Locale(identifier: "zh_Hant_TW")
        timeFormatter.dateFormat = "HH:mm"
        date = dateFormatter.string(from: currentDate)
        time = timeFormatter.string(from: currentDate)
    }

    override func viewDidLoad() {
        //view.backgroundColor = .clear
        calendar.delegate = self
        configureDateTime()
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("selected")
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
//        print(formatter.string(from: date))
        self.date = formatter.string(from: date)
    }
    @IBAction func pressedDone(_ sender: UIButton) {
        dateAndTime = date + " " + time
        dismiss(animated: true) {
            self.delegate.pass(data: self.dateAndTime)
        }
    }
}

