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



    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(mainImageView)
        self.addSubview(titleLabel)

        setImageConstraints()
        setTitleConstraints()

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


    func renderText() {
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
    }


    func setImageConstraints() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainImageView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
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
