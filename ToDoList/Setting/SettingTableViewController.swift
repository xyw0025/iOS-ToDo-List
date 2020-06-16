//
//  SettingTableViewController.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/16.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit
import SideMenu

struct CellData {
    let image: UIImage?
    let title: String?
}

class SettingTableViewController: UITableViewController {
    var menu: SideMenuNavigationController?
    var data = [CellData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        data = [CellData.init(image: #imageLiteral(resourceName: "Tune"), title: "Theme"), CellData.init(image: #imageLiteral(resourceName: "Tune"), title: "About"), CellData.init(image: #imageLiteral(resourceName: "Tune"), title: "Help")]
        self.tableView.register(SettingCell.self, forCellReuseIdentifier: "custom")

        renderSideMenu()

    }



    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! SettingCell
        cell.icon = data[indexPath.row].image
        cell.title = data[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    // MARK: - Side menu

    func renderSideMenu() {
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
