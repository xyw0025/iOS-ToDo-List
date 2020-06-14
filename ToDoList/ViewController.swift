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
          navigationController?.hideNavigationItemBackground()
          view.backgroundColor = .white
          self.navigationController?.isNavigationBarHidden = true
          menu = SideMenuNavigationController(rootViewController: MenuListController())
          menu?.leftSide = true
          menu?.setNavigationBarHidden(true, animated: false)

          SideMenuManager.default.leftMenuNavigationController = menu
          menu?.statusBarEndAlpha = 0


          SideMenuManager.default.addPanGestureToPresent(toView: self.view)
          // Do any additional setup after loading the view.
      }



}





class MenuListController: UITableViewController {
    var items = ["Index", "Today", "Settings"]

    // FF8552
    var darkColor = UIColor(hex: "#FF8552")

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear


        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = darkColor
        self.navigationController?.isNavigationBarHidden = true

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension UIColor{
    public  convenience init(hex : String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
            return
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
