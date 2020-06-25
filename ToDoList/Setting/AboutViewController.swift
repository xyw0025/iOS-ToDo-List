//
//  AboutViewController.swift
//  ToDoList
//
//  Created by Wen Hsin-Yu on 2020/6/25.
//  Copyright © 2020 tina. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    var textLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textLabel)
        configureTextLabel()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TestTEstTEST", style: .plain, target: nil, action: nil)
        navigationItem.title = "TestTest TEST"
    }
    func configureTextLabel() {
        textLabel.pin(to: view)
        textLabel.text = "TestTEstTEST"
        textLabel.textAlignment = .center
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
