//
//  MenuListController.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/16.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit
import SideMenu

class MenuListController: UITableViewController {
    var items = ["Index", "Today", "Settings"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.navigationController?.isNavigationBarHidden = true
        configureTableView()

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func configureTableView() {

        tableView.backgroundColor = UIColor.theme

        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 80
//        tableView.pin(to: view)
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor.theme
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case [0,0]:
            print("0")
        case [0,1]:
            print("1")
        default:
            print("3")
        }
//        print(indexPath)

    }
}


extension UINavigationController {
    func hideNavigationItemBackground() {
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear
    }
}
// TODO: Constraints
// TODO: highlight only cell title when triggered
// TODO: segue
