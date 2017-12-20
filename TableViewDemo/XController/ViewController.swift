//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Xu on 2017/12/15.
//  Copyright © 2017年 Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        self.view.addSubview(self.tableView)
        
        unowned let weakSelf = self
        XNewWorkManger.requestNetWork(success: { (data) in
            weakSelf.tableView.data = data 
            weakSelf.tableView.reloadData()
        }) { (error) in
            
        }

    }
    
    
    
    lazy var tableView:XTableview = {
        let table:XTableview = XTableview.init(frame: self.view.bounds, style: .grouped)
        return table
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

