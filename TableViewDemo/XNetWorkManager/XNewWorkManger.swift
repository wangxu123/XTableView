//
//  XNewWorkManger.swift
//  TableViewDemo
//
//  Created by Xu on 2017/12/15.
//  Copyright © 2017年 Xu. All rights reserved.
//

import UIKit

class XNewWorkManger {

    class func requestNetWork(success successHandle:@escaping ([XCoordiantor])->Void,
                              faile faileHandle:(String)->Void) {
        
        /**
         一般app首页的数据都比较大，为了首页的用户访问速度，大部分都不会在一个接口里面把数据返回
         像天猫，京东之类的，首页上半部分基本是是不变的，下半部分是一个可刷新加载的列表页
         肯定不可能放在一个接口里面，分开了之后反而方便管理 ，多接口的优势有很多，这里只是举个例子。
         */
        DispatchQueue.global().async {
            let path:String = Bundle.main.path(forResource: "ServerData", ofType: "plist")!
            let data:NSDictionary = NSDictionary.init(contentsOfFile: path)!
            let dataList:[Any] = data["one"] as! [Any]
            var coorArr:[XCoordiantor] = [XCoordiantor]()
            for item in 0..<dataList.count {
                let coor:XCoordiantor = XCoordiantor()
                coor.data = dataList[item] as! [String:Any]
                coorArr.append(coor)
            }
            DispatchQueue.main.async(execute: {
                successHandle((coorArr as [XCoordiantor]))
            })
        }
        
        /**
         多接口网络请求管理可以采用采用多线程的组线程来管理
         let group:DispatchGroup = DispatchGroup.init()
         DispatchGroup.enter()
         DispatchGroup.leave()
         DispatchGroup.notify()
         */
        
    }
}
