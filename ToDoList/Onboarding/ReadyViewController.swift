//
//  ReadyViewController.swift
//  ToDoList
//
//  Created by tina on 2020/6/23.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit

class ReadyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextPageButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(identifier: "mainVC") as! HomeTabBarController
        self.present(mainVC, animated: true, completion: nil)
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
