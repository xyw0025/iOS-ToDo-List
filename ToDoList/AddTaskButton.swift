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
        self.backgroundColor = .purple
        self.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
    }

    @objc func clickButton() {
        print("clicked add button")
    }
    func configureButton(to view: UIView) {
        view.addSubview(self)
        self.pinToRightBottom(to: view)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
