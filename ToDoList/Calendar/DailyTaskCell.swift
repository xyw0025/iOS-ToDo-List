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
    var title: String?
    var content: String?
//    var icon: UIImage?

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



    func setTask(to task: Task) {
        title = task.title
        content = task.content

    }
    func setTheme(isDarkMode: Bool) {
//        print(isDarkMode)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(cellBackground)
        self.addSubview(titleLabel)

        setTitleConstraints()
        setBackgroundConstraints()
    }
    // table cell's color: when the cell is pressed & and the cell is not triggered
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted == true {
            cellBackground.backgroundColor = LightModeColor.cellTriggerdColor
        } else {
            cellBackground.backgroundColor = LightModeColor.cellColor
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if let title = title {
            titleLabel.text = title
        }

    }
    func setBackgroundConstraints() {
        cellBackground.layer.cornerRadius = cellCornerRaius
        cellBackground.translatesAutoresizingMaskIntoConstraints = false
        cellBackground.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cellBackground.heightAnchor.constraint(equalToConstant: cellbackgroundHeight).isActive = true
        cellBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true

//        cellBackground.widthAnchor.constraint(equalTo: widthAnchor, constant: 20).isActive = true

    }

    func renderText() {
        if (true) {
            titleLabel.textColor = LightModeColor.textColor
        }
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
    }



    func setTitleConstraints() {
//        titleLabel.pin(to: cellBackground)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: cellBackground.leftAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
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

    private struct LightModeColor {
        static var cellColor: UIColor  { return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.2057737586) }
        static var cellTriggerdColor: UIColor { return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) }
        static var textColor: UIColor {return .black}
    }
    struct DarkModeColor {

    }

}

