//
//  ViewController.swift
//  ToDoList
//
//  Created by tina on 2020/6/13.
//  Copyright © 2020 tina. All rights reserved.
//
import SideMenu
import UIKit

class ViewController: UIViewController {

    var menu: SideMenuNavigationController?

      override func viewDidLoad() {
        super.viewDidLoad()
        if isDarkMode() {print("isDarkMode")} else {
            print("isntDarkMode")
        }

        navigationController?.hideNavigationItemBackground()
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        menu?.statusBarEndAlpha = 0
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
      }




}

extension UIViewController {
    func isDarkMode() -> Bool {
        switch traitCollection.userInterfaceStyle {
        case .light: return false
        case .dark: return true
        case .unspecified: return false
        @unknown default:
            return false
        }
    }
}


