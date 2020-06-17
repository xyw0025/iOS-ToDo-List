//
//  SettingsTableViewController.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/16.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit
import SideMenu

class SettingsTableViewController: UIViewController {
    var menu: SideMenuNavigationController?
    var tableView = UITableView()
    var items = [Item]()
    var someRandomText = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        items = fetchItems()
        configureTableView()
        configureTextLabel()
        setTableViewDelegates()
        renderSideMenu()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? settingItemsTableController

        if let row = tableView.indexPathForSelectedRow?.row{
            controller?.settingTitle = items[row].title
        }

    }

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

    func configureTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 80
        tableView.register(SettingCell.self, forCellReuseIdentifier: "settingCell")
        tableView.pin(to: view)
    }

    func configureTextLabel() {
        someRandomText.text = "credit"
        view.addSubview(someRandomText)
        someRandomText.pin(to: tableView)
    }


    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension SettingsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") as! SettingCell
        cell.selectionStyle = .none
        let item = items[indexPath.row]
        cell.setItems(to: item)
//
//        if cell.title == "About" {
//            cell.accessoryView =
//
//        }
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let content = SettingItemsViewController()

        if let controller = storyboard?.instantiateViewController(withIdentifier: "secondPage") {
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
//        self.present(content, animated: true, completion: nil)

//            tableView.deselectRow(at: indexPath, animated: false)
    }

    
}

struct Item {
    var icon: UIImage
    var title: String
}

extension SettingsTableViewController {
    func fetchItems() -> [Item] {
        let item1 = Item(icon: UIImage(named: "Tune")!, title: "Theme")
        let item2 = Item(icon: UIImage(named: "Tune")!, title: "About")
        return [item1, item2]
    }
}
// TODO: entering the cell

