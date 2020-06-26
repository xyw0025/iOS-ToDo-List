//
//  UIViewExtenstion.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/16.
//  Copyright © 2020 tina. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func pin(to superView: UIView, for bottomConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor, constant: topAnchorConstraintsConstant).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    func pinOver(to superView: UIView, below topView: UIView,for bottomConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: bottomConstant).isActive = true
    }
    func pinToRightBottom(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: buttonRadius).isActive = true
        widthAnchor.constraint(equalToConstant: buttonRadius).isActive = true
//        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: bottomConstraintsConstant).isActive = true
        trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor, constant: bottomConstraintsConstant).isActive = true

    }


}




extension UIView {
    var topAnchorConstraintsConstant: CGFloat { return 65 }
    var bottomConstraintsConstant: CGFloat {return -30}
    var buttonRadius: CGFloat {return 60}
}

