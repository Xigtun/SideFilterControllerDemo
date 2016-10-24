//
//  ViewController.swift
//  SideFilterControllerDemo
//
//  Created by cysu on 24/10/2016.
//  Copyright © 2016 cysu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "List"

        let rightItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(rightItemAction(_:)))
        self.navigationItem.rightBarButtonItem = rightItem

    }

    func rightItemAction(_ sender: Any) {
        let nav = FilterNavController.init(rootViewController: FilterController())
        self.present(nav, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

