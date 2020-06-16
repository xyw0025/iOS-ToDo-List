//
//  CustomCell.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/16.
//  Copyright © 2020 tina. All rights reserved.
//

import Foundation
import UIKit
class SettingCell: UITableViewCell {
    var title: String?
    var icon: UIImage?

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

    var mainImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    func setItems(to item: Item) {
        title = item.title
        icon = item.icon
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(cellBackground)
        self.addSubview(mainImageView)
        self.addSubview(titleLabel)

        setImageConstraints()
        setTitleConstraints()
        setBackgroundConstraints()
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted == true {
            cellBackground.backgroundColor = cellTriggerdColor
        } else {
            cellBackground.backgroundColor = cellColor
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        if let title = title {
            titleLabel.text = title
        }
        if let image = icon {
            mainImageView.image = image
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
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
    }


    func setImageConstraints() {

        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor).isActive = true
    }

    func setTitleConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: mainImageView.rightAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SettingCell {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.15
    }
    private var cellCornerRaius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cellbackgroundHeight: CGFloat  { return 65 }
    private var cellColor: UIColor  { return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.2057737586) }
    private var cellTriggerdColor: UIColor { return #colorLiteral(red: 1, green: 0.5215686275, blue: 0.3215686275, alpha: 0.4017283818) }

}


