//
//  XCoordiantor.swift
//  TableViewDemo
//
//  Created by Xu on 2017/12/15.
//  Copyright © 2017年 Xu. All rights reserved.
//

import UIKit


@objc protocol XCoordiantorProtocol {
    
    @objc optional var isShow:Bool {set get}
    var data:[String:Any]!  {set get}
    var cellHeight:CGFloat {set get}
    var cellIdentifier:String {get}
}

protocol XCellSourceProtocol {
    /**
     @parma coordiantor 协调者
     @parma tableView 承载cell的tableview
     @parma data tableview的数据源
     @parma indexPath 
     */
    func configCell(coordiantorObj coordiantor:XCoordiantor,
                    xTableview tableView:XTableview,
                    dataSource data:[XCoordiantor],
                    xTableViewIndex indexPath:NSIndexPath) -> Void
    
}

class XCoordiantor: XCoordiantorProtocol{
    var cellHeight: CGFloat = 0.0
    var cellIdentifier: String = ""
    var isShow: Bool = false
    let itemWidth = UIScreen.main.bounds.size.width/6

    
    var data: [String : Any]! = [String:Any]() {
        didSet {
            guard let responseData:[String:Any] = data else { return }
            
            let templateCode:String = responseData["templateCode"] as! String
            
            switch templateCode {
            case "1":
                self.cellHeight = 80
                self.cellIdentifier = "XCell1"
                break
                
            case "2":
                self.cellHeight = 100 + itemWidth + 40
                self.cellIdentifier = "XCell2"
                break
            case "3":
                self.cellHeight = 120
                self.cellIdentifier = "XCell3"
                break
            case "4":
                self.cellHeight = 120
                self.isShow = false
                self.cellIdentifier = responseData["dataId"] as! String
                break
                
            default:
                print("")
            }
        }
    }
    
}
