//
//  XCell2.swift
//  TableViewDemo
//
//  Created by Xu on 2017/12/15.
//  Copyright © 2017年 Xu. All rights reserved.
//

import UIKit

let itemWidth = UIScreen.main.bounds.size.width/6

class XCell2: UITableViewCell,XCellSourceProtocol {
    
    var coor:XCoordiantor? = nil
    var isShow:Bool = false
    
    weak var table:XTableview? = nil
    var totalData:[XCoordiantor]? = nil
    var currentIndex:NSIndexPath? = nil
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
    }
    
    func configCell(coordiantorObj coordiantor: XCoordiantor, xTableview tableView: XTableview, dataSource data: [XCoordiantor], xTableViewIndex indexPath: NSIndexPath) {
        
        if (self.coor != nil) && (ObjectIdentifier(self.coor!) == ObjectIdentifier(coordiantor)) { return }
        self.coor = coordiantor
        
        self.table = tableView
        self.totalData = data
        self.currentIndex = indexPath
        
        self.isShow = coordiantor.isShow
        let dataList:[Any] = coordiantor.data["dataList"] as! [Any]
        
        self.remoAllViews()
        self.dataArray.removeAllObjects()
        
        self.dataArray.addObjects(from: dataList)
        setupViews()
        
    }
    
    func remoAllViews() -> Void{
        for subView:Any in self.viewArr {
            (subView as AnyObject).removeFromSuperview()
        }
    }
    
    func setupViews() ->Void{
        
        self.contentView.addSubview(firstImage)
        let lineNum:Int = (self.dataArray.count - 1)/6
        let otherNum:Int = (self.dataArray.count - 1)%6
        let datas:(NSMutableArray, NSMutableArray) = hanleData(lineNum, otherNum)
        createViews(lineNum, otherNum, datas.0, datas.1)
        contentView.addSubview(self.showImage)
        showImageHandle(lineNumber: lineNum, otherNumber: otherNum)

    }
    
    // 数据处理下，方便后面的赋值
    func hanleData(_ lineNum:Int, _ otherNum:Int) -> (NSMutableArray, NSMutableArray) {
        let newArr:NSMutableArray = self.dataArray
        newArr.removeLastObject()
        
        let lineArr:NSMutableArray = NSMutableArray()
        for i in 0..<lineNum {
            let temArr:NSMutableArray = NSMutableArray()
            for j in 0..<6 {
                temArr.add(newArr[i*6 + j])
            }
            lineArr.add(temArr)
        }
        
        let otherArr:NSMutableArray = NSMutableArray()
        for i in 0..<otherNum {
            otherArr.add(newArr[lineNum*6 + i])
        }
        
        return (lineArr, otherArr)
    }
    
    func createViews(_ lineNum:Int, _ otherNum:Int,_ lineDataSource:NSArray,_ otherDataSource:NSArray) -> Void {
        // 创建整行的
        for lineItem in 0..<lineNum {
            let data:NSArray = lineDataSource[lineItem] as! NSArray
            let containView:UIView = UIView.init(frame: CGRect(x:0, y:100 + (CGFloat(lineItem) * itemWidth), width:screen_width, height:itemWidth))
            for item in 0..<6 {
                let frame:CGRect = CGRect(x: CGFloat(item)*itemWidth, y:0, width:itemWidth, height:itemWidth)
                let imagePathDic:NSDictionary = data[item] as! NSDictionary
                let temImg = createTemImageView(frame, imagePathDic["imagePath"] as! String, "ico_p3-3")
                containView.addSubview(temImg)
            }
            self.viewArr.add(containView)
            self.contentView.addSubview(containView)
        }
        
        // 创建不足整行的
        let containView:UIView = UIView.init(frame: CGRect(x:0, y:100 + CGFloat(lineNum)*itemWidth, width:screen_width, height:itemWidth))
        for otherItem in 0..<otherNum {
            let centerX:CGFloat = (screen_width/2.0)-(CGFloat((otherNum-1))*(itemWidth/2.0))
            let frame:CGRect = CGRect(x:0, y:0, width:itemWidth, height:itemWidth)
            let center:CGPoint = CGPoint(x:centerX + CGFloat(otherItem)*itemWidth, y:itemWidth/2)
            let imagePathDic:NSDictionary = otherDataSource[otherItem] as! NSDictionary
            let temImag = createTemImageView(frame, imagePathDic["imagePath"] as! String, "ico_p3-3")
            temImag.center = center
            containView.addSubview(temImag)
        }
        self.viewArr.add(containView)
        self.contentView.addSubview(containView)
    }
    
    func createTemImageView(_ imgFrame:CGRect, _ imgPath:String, _ placeholderImg:String) -> UIImageView {
        
        let img:UIImageView = UIImageView.init(frame: imgFrame)
        img.sd_setImage(with: URL.init(string: imgPath)!, placeholderImage: UIImage.init(named: placeholderImg))
        return img
    }
    
    // 控制显示状态
    func showImageHandle(lineNumber lineNum:Int, otherNumber otherNum:Int) ->Void {
        if self.isShow {
            for item in 0..<self.viewArr.count {
                let containView:UIView = self.viewArr[item] as! UIView
                containView.isHidden = false
                
            }
            self.showImage.frame = CGRect(x:screen_width/2.0 - 60/2.0, y:100 + CGFloat(lineNum)*itemWidth + (otherNum == 0 ? 0 : itemWidth),width:60, height:40)
            
        } else {
            for item in 0..<self.viewArr.count {
                let containView:UIView = self.viewArr[0] as! UIView
                let temView:UIView = (self.viewArr[item]) as! UIView
                if (containView.isEqual(temView as AnyObject))  {
                    temView.isHidden = false
                } else {
                    temView.isHidden = true
                }
            }
            self.showImage.frame = CGRect(x:screen_width/2.0 - 60/2.0, y:100 + itemWidth,width:60, height:40)
        }
    }
    
   
    
    
    // 展开按钮点击事件
    @objc func clickBtn(_ btn:UIButton) ->Void{
        self.isShow = !self.isShow
        
        unowned let weakSelf = self
        let temCoor:XCoordiantor = self.totalData![(currentIndex?.row)!]
        let lineNum:Int = (self.dataArray.count - 1)/6
        let otherNum:Int = (self.dataArray.count - 1)%6
        
        
        if #available(iOS 11.0, *) {
            
            self.table?.performBatchUpdates({
                if weakSelf.isShow {
                    temCoor.cellHeight = 100 + CGFloat(itemWidth) + (otherNum == 0 ? 0 : itemWidth) + 40
                } else {
                    temCoor.cellHeight = 100 + itemWidth + 60
                }
                
            }, completion: { (isFinish) in
            })
            
        } else {
            
            self.table?.beginUpdates()
            if self.isShow {
                temCoor.cellHeight = 100 + CGFloat(itemWidth) + (otherNum == 0 ? 0 : itemWidth) + 40
            } else {
                temCoor.cellHeight = 100 + itemWidth + 60
            }
            self.table?.endUpdates()
            
        }
        weakSelf.showImageHandle(lineNumber: lineNum, otherNumber: otherNum)


        
    }
    
    lazy var showImage:UIButton = {
        let btn:UIButton = UIButton.init(type: .custom)
        btn.frame = CGRect(x:self.screen_width/2 - 30, y:100+40, width:60, height:60)
        btn.setTitle("展开", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.addTarget(self, action: #selector(clickBtn(_ :)), for: .touchUpInside)
        return btn
    }()
    
    lazy var firstImage:UIImageView = {
        let img:UIImageView = UIImageView.init()
        img.frame = CGRect(x:0,y:0,width:self.screen_width,height:100)
        img.backgroundColor = UIColor.orange
        return img
    }()

    lazy var viewArr: NSMutableArray = {
        let arr = NSMutableArray()
        return arr
    }()
    
    lazy var dataArray:NSMutableArray = {
        let arr = NSMutableArray()
        return arr
    }()
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
