//
//  CalenderViewController.swift
//  ToDoList
//
//  Created by tina on 2020/6/23.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit

class CalenderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextPageButton(_ sender: Any) {
        self.performSegue(withIdentifier: "Calender", sender: self)
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
