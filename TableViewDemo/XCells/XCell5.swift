//
//  XCell5.swift
//  TableViewDemo
//
//  Created by Xu on 2017/12/15.
//  Copyright © 2017年 Xu. All rights reserved.
//

import UIKit

class XCell5: UITableViewCell,XCellSourceProtocol {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    
    func configCell(coordiantorObj coordiantor: XCoordiantor,
                    xTableview tableView: XTableview,
                    dataSource data: [XCoordiantor],
                    xTableViewIndex indexPath: NSIndexPath) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    

}
