//
//  TypeCast.swift
//  CPAlertViewController
//
//  Created by ZhaoWei on 15/12/8.
//  Copyright © 2015年 CP3HNU. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    var f: CGFloat { return CGFloat(self) }
}

extension Float {
    var f: CGFloat { return CGFloat(self) }
}

extension Double {
    var f: CGFloat { return CGFloat(self) }
}

extension CGFloat {
    var swf: Float { return Float(self) }
}

public class CPAdaptiveTextView : UITextView {
    
    var fixedWidth: CGFloat = 0.0
    override public func intrinsicContentSize() -> CGSize {
        
        if self.text == nil || self.text.isEmpty {
            return CGSizeMake(fixedWidth, 0)
        }
        
        let text: NSString = self.text
        let font = self.font ?? UIFont.systemFontOfSize(CPAlertViewController.messageFontSize)
        
        let rect = text.boundingRectWithSize(CGSize(width: fixedWidth - 2 * self.textContainer.lineFragmentPadding, height: CGFloat.max), options: [.UsesFontLeading, .UsesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil)
        
        let vPadding = self.textContainerInset.top + self.textContainerInset.bottom
        let size = CGSizeMake(ceilf(rect.size.width.swf).f, ceilf(rect.size.height.swf).f + vPadding)
        
        return size
    }
}

extension UIColor {
    class func colorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func image() -> UIImage {
        
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, self.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
