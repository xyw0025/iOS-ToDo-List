//
//  SettingTableViewController.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/16.
//  Copyright © 2020 tina. All rights reserved.
//

//import UIKit
//import SideMenu
//import Foundation
//
//struct CellData {
//    let image: UIImage?
//    let title: String?
//}
//
//class SettingTableViewController: UIViewController {
//    var tableView = UITableView()
//    var menu: SideMenuNavigationController?
//    var data = [CellData]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//
//        
//        data = [CellData.init(image: #imageLiteral(resourceName: "Tune"), title: "Theme"), CellData.init(image: #imageLiteral(resourceName: "Tune"), title: "About"), CellData.init(image: #imageLiteral(resourceName: "Tune"), title: "Help")]
//        tableView.register(SettingCell.self, forCellReuseIdentifier: "custom")
//
//        renderSideMenu()
//
//
//    }
//    func configureTableView() {
////        view.addSubview(tableView)
//    }
//
//    func setTableViewDelegates() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//
//    // MARK: - Table view data source
//
//
//
//
//    // MARK: - Side menu
//
//    func renderSideMenu() {
//        navigationController?.hideNavigationItemBackground()
//        view.backgroundColor = .white
//        self.navigationController?.isNavigationBarHidden = true
//        menu = SideMenuNavigationController(rootViewController: MenuListController())
//        menu?.leftSide = true
//        menu?.setNavigationBarHidden(true, animated: false)
//        SideMenuManager.default.leftMenuNavigationController = menu
//        menu?.statusBarEndAlpha = 0
//        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
//    }
//
//
//}
