//
//  XCell1.swift
//  TableViewDemo
//
//  Created by Xu on 2017/12/15.
//  Copyright © 2017年 Xu. All rights reserved.
//

import UIKit

class XCell1: UITableViewCell,XCellSourceProtocol {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.bannerImage)
    }
    
    
    
    
    func configCell(coordiantorObj coordiantor: XCoordiantor,
                    xTableview tableView: XTableview,
                    dataSource data: [XCoordiantor],
                    xTableViewIndex indexPath: NSIndexPath) {
        
        
        
    }
    

    
    lazy var bannerImage:UIImageView = {
        let image:UIImageView = UIImageView()
        return image
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
