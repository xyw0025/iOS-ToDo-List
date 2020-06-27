//
//  AddTaskButton.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/26.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit

class AddTaskButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.theme
        let addImage = UIImage(named: "addButton")?.withTintColor(.white)
        self.setImage(addImage, for: .normal)
//        self.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
    }


    @objc func clickButton() {
//        print("clicked add button")
    }
    func configureButton(to view: UIView) {
        buttonShadow()

        view.addSubview(self)
        self.pinToRightBottom(to: view)
        self.layer.cornerRadius = cornerRadius

    }

    func buttonShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.3

        self.layer.shadowRadius = 10
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension AddTaskButton {
    var cornerRadius: CGFloat {return 30}
}
