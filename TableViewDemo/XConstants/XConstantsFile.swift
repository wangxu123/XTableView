//
//  XConstantsFile.swift
//  TableViewDemo
//
//  Created by Xu on 2017/12/15.
//  Copyright © 2017年 Xu. All rights reserved.
//

import UIKit

extension UIView {
   

    
    var xw_width:CGFloat {
        return self.frame.size.width
    }
    var xw_height:CGFloat {
        return self.frame.size.height
    }
    var xw_x:CGFloat {
        return self.frame.origin.x
    }
    var xw_y:CGFloat {
        return self.frame.origin.y
    }
}

extension NSObject {
    var screen_width:CGFloat{
        return UIScreen.main.bounds.size.width
    }
    
    var screen_height:CGFloat {
        return UIScreen.main.bounds.size.height
    }

}

extension UIImageView {

    func imageViewClick(jumpData data:NSDictionary) ->Void{
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapMethod(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func tapMethod(_ imageViewTap:UITapGestureRecognizer) ->Void{
        
    }
}
