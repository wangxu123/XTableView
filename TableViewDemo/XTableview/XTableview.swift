//
//  XTableview.swift
//  TableViewDemo
//
//  Created by Xu on 2017/12/15.
//  Copyright © 2017年 Xu. All rights reserved.
//

import UIKit

class XTableview: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        baseSetting()
        registerCellClass()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func baseSetting() ->Void{
        self.dataSource = self
        self.delegate = self
        self.rowHeight = 0.0
        self.sectionFooterHeight = 0.0
        self.sectionHeaderHeight = 0.0
        
        if #available(iOS 11.0, *) {
            self.estimatedRowHeight = 0.0
            self.estimatedSectionFooterHeight = 0.0
            self.estimatedSectionHeaderHeight = 0.0
        }
    }
    
    func registerCellClass() ->Void{
        self.register(XCell1.classForCoder(), forCellReuseIdentifier: "XCell1")
        self.register(XCell2.classForCoder(), forCellReuseIdentifier: "XCell2")
        self.register(XCell3.classForCoder(), forCellReuseIdentifier: "XCell3")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coor:XCoordiantor = self.dataArray[indexPath.row] as! XCoordiantor
        var cell:XCellSourceProtocol? = nil
        if coor.data["templateCode"] as! String == "4" {
            cell = XCell4.init(style: .default, reuseIdentifier: coor.cellIdentifier)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: coor.cellIdentifier, for: indexPath) as? XCellSourceProtocol
        }
        cell?.configCell(coordiantorObj: coor, xTableview: self, dataSource: self.dataArray as! [XCoordiantor], xTableViewIndex: indexPath as NSIndexPath)
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let coor:XCoordiantor = self.dataArray[indexPath.row] as! XCoordiantor
        return coor.cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    var data:[XCoordiantor] = [XCoordiantor](){
        didSet {
            self.dataArray.removeAllObjects()
            self.dataArray.addObjects(from: data)
        }
    }
    
    lazy var dataArray:NSMutableArray = {
        let data = NSMutableArray()
        return data
    }()
}
