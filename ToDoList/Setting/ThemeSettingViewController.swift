//
//  ThemeSettingViewController.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/25.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit

class ThemeSettingViewController: UIViewController {

    var themeName = ""
    var changeTestButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(changeTestButton)

        view.backgroundColor = UIColor.backgroundColor
        configureNav()
        configureButton()
    }


    func configureButton() {
        changeTestButton.frame = CGRect(x: 50, y: 200, width: 50, height: 50)
//        changeTestButton.pin(to: view)
        changeTestButton.backgroundColor = .purple
        changeTestButton.addTarget(self, action: #selector(clickTestButton), for: .touchUpInside)

    }


    @objc func clickTestButton() {
//        UIColor.backgroundColor = UIColor.DarkMode.backgroundColor
        DispatchQueue.main.async {
           self.view.backgroundColor = UIColor.blue
        }
        
    }
    func configureNav() {
        navigationItem.title = "Themes"
    }


    func changeThemeColor(themeName: String) {

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
