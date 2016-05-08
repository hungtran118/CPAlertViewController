//
//  ViewController.swift
//  CPAlertViewController
//
//  Created by ZhaoWei on 15/12/8.
//  Copyright © 2015年 CP3HNU. All rights reserved.
//

import UIKit
import CPAlertViewController

class ViewController: UICollectionViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CPCollectionViewCell
    
        var title: String = "Title"
        var detail: String = "Detail"
        switch indexPath.row {
        case 0:
            title = "Success"
            detail = "Normal"
        case 1:
            title = "Error"
            detail = "Normal"
        case 2:
            title = "Warning"
            detail = "Normal"
        case 3:
            title = "Info"
            detail = "Normal"
        case 4:
            title = "None Image"
            detail = "Normal"
        case 5:
            title = "Custom image"
            detail = "Normal"
        case 6:
            title = "Success"
            detail = "Two buttons"
        case 7:
            title = "Success"
            detail = "Long title"
        case 8:
            title = "Success"
            detail = "Very long title"
        case 9:
            title = "Success"
            detail = "Long message"
        case 10:
            title = "Success"
            detail = "Very long message"
        case 11:
            title = "Success"
            detail = "No title"
        case 12:
            title = "Success"
            detail = "No message"
        default:
            break
        }
        
        cell.titleLabel.text = title
        cell.detailLabel.text = detail
       
        return cell;
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            show1()
        case 1:
            show2()
        case 2:
            show3()
        case 3:
            show4()
        case 4:
            show5()
        case 5:
            show6()
        case 6:
            show7()
        case 7:
            show8()
        case 8:
            show9()
        case 9:
            show10()
        case 10:
            show11()
        case 11:
            show12()
        case 12:
            show13()
        //Test
//        case 13:
//            show14()
//        case 14:
//            show15()
        default:
            break
        }
    }
    
    func show1() {
        CPAlertViewController().showSuccess(title:"Title", message: "Message")
    }
    
    func show2() {
        CPAlertViewController().showError(title:"Title", message: "Message")
    }
    
    func show3() {
        CPAlertViewController().showWarning(title:"Title", message: "Message")
    }
    
    func show4() {
        CPAlertViewController().showInfo(title:"Title", message: "Message")
    }
    
    func show5() {
        CPAlertViewController().show(title: "Title", message: "Message", style: .None)
    }
    
    func show6() {
        CPAlertViewController().show(title: "Title", message: "Message", style: .CustomImage(imageName: "thumb"))
    }
    
    func show7() {
        
        CPAlertViewController().showSuccess(title: "Title", message: "Message", buttonTitle: "确定", otherButtonTitle: "取消", action:{(buttonIndex: Int) -> Void in
            print("Clicked at index = ", buttonIndex)
        })
    }
    
    func show8() {
        CPAlertViewController().showSuccess(title:"Titletitletitletitletitletitletitletitletitletitletitle", message: "Message")
    }
    
    func show9() {
        
        CPAlertViewController().showSuccess(title:"Titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle", message: "Message")
    }
    
    func show10() {
        
        CPAlertViewController().showSuccess(title:"Title", message: "MessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessage")
    }
    
    func show11() {
        
        CPAlertViewController().showSuccess(title:"Title", message: "MessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessageMessage")
    }
    
    func show12() {
        
        CPAlertViewController().showSuccess(title: nil, message: "Message")
    }
    
    func show13() {
        
        CPAlertViewController().showSuccess(title: "Title", message: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
    }
}

