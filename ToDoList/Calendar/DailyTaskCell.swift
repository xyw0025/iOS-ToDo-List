//
//  DailyTaskCellTableViewCell.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/17.
//  Copyright © 2020 tina. All rights reserved.
//

import Foundation
import UIKit


class DailyTaskCell: UITableViewCell {
    var id: String?
    var title: String?
    var content: String?
    var date: String?
    var status: Bool?


    var statusButton: UIButton = {
        var button = UIButton()
               button.translatesAutoresizingMaskIntoConstraints = false
               return button
    }()
    var cellBackground: UIView = {
        var background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()

    var titleLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    var dateLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    func setTask(to task: Task) {
        title = task.title
        content = task.content
        date = task.date
        status = task.status
        id = task.id
    }
    func setTheme(isDarkMode: Bool) {
//        print(isDarkMode)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(cellBackground)
        self.addSubview(titleLabel)
        self.addSubview(dateLabel)
        self.addSubview(statusButton)
        configure()

    }

    // table cell's color: when the cell is pressed & and the cell is not triggered
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted == true {
            cellBackground.backgroundColor = UIColor.LightMode.cellTriggerdColor
        } else {
            cellBackground.backgroundColor = UIColor.LightMode.cellColor
        }
    }

    func configure() {
        statusButton.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        setStatusButtonConstraints()
        setBackgroundConstraints()
        setTitleConstraints()
        setDateLabelConstraints()
    }

    @objc func toggleCheckbox() {
        var task = TaskArchive()
        task.toggleTaskStatus(key: (id ?? nil)!)
        if status == false {
            statusButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            statusButton.setImage(UIImage(systemName: "square"), for: .normal)
        }


    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let title = title {
            titleLabel.text = title
        }
        if let date = date {
            dateLabel.text = date
        }

    }


    func setBackgroundConstraints() {
        cellBackground.layer.cornerRadius = cellCornerRaius
        cellBackground.translatesAutoresizingMaskIntoConstraints = false
        cellBackground.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cellBackground.heightAnchor.constraint(equalToConstant: cellbackgroundHeight).isActive = true
        cellBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }

    func setStatusButtonConstraints() {
        statusButton.setImage(UIImage(systemName: "square"), for: .normal)
        statusButton.layer.cornerRadius = cellCornerRaius
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        statusButton.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 0).isActive = true
//        statusButton.backgroundColor = .purple
        statusButton.heightAnchor.constraint(equalToConstant: cellbackgroundHeight).isActive = true
        statusButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
//        statusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200).isActive = true
    }


    func setTitleConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: statusButton.rightAnchor, constant: buttonTitleConstraints).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }


    func setDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
//        dateLabel.leftAnchor.constraint(equalTo: cellBackground.leftAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: cellBackground.rightAnchor, constant: -12).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }

    func renderText() {
        if (true) {
            titleLabel.textColor = UIColor.LightMode.textColor
        }
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
    }




    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DailyTaskCell {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.15
    }
    private var cellCornerRaius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cellbackgroundHeight: CGFloat  { return 65 }

}

// TODO: event date dotted
// TODO: dark mode change theme

extension DailyTaskCell {
    var buttonTitleConstraints: CGFloat { return CGFloat(layer.bounds.width * 0.01)}
    var buttonWidth: CGFloat { return CGFloat(layer.bounds.width * 0.1)}
}
