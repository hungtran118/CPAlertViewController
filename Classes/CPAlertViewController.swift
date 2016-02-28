//
//  CPAlertViewController.swift
//  CPAlertViewController
//
//  Created by ZhaoWei on 15/12/8.
//  Copyright © 2015年 CP3HNU. All rights reserved.
//

import UIKit

public enum CPAlertStyle {
    case Success, Error, Warning, Info, None
    case CustomImage(imageName: String)
}

public typealias UserAction = ((buttonIndex: Int) -> Void)

public class CPAlertViewController: UIViewController {
    
    //MARK: - Custom Properties
    public static var titleFontSize: CGFloat = 22.0
    public static var messageFontSize: CGFloat = 16.0
    public static var buttonFontSize: CGFloat = 16.0
    public static var titleColor = UIColor.colorFromRGB(0x333333)
    public static var messageColor = UIColor.colorFromRGB(0x555555)
    public static var buttonTitleColor = UIColor.whiteColor()
    public static var buttonBGNomalColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    public static var buttonBGHighlightedColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 0.7)
    
    //MARK: - Const
    private let kBGTransparency: CGFloat = 0.5
    private let kVerticalGap: CGFloat = 15.0
    private let kWidthMargin: CGFloat = 15.0
    private let kHeightMargin: CGFloat = 15.0
    private let kContentWidth: CGFloat = 270.0
    private let kContentHeightMargin: CGFloat = 20.0
    private let kButtonHeight: CGFloat = 35.0
    private let kTitleLines: Int = 3
    private let kImageViewWidth: CGFloat = 30.0
    private let kImageViewHeight: CGFloat = 30.0
    private let kButtonBaseTag: Int = 100
    private let kButtonHoriSpace: CGFloat = 20.0
    private var imageViewSpace: CGFloat = 0.0
    private var titleLabelSpace: CGFloat = 0.0
    private var messageTextViewSpace: CGFloat = 0.0
    
    //MARK: - View
    private var strongSelf: CPAlertViewController?
    private var contentView = UIView()
    private var imageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var messageTextView = CPAdaptiveTextView()
    private var buttons: [UIButton] = []
    private var userAction: UserAction? = nil
    
    //MARK: - Init
    public init() {
        
        super.init(nibName: nil, bundle: nil)
        
        self.view.frame = UIScreen.mainScreen().bounds
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        self.view.backgroundColor = UIColor(white: 0.0, alpha: kBGTransparency)
        
        strongSelf = self
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    private func setupContentView() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        contentView.layer.borderColor = UIColor.colorFromRGB(0xCCCCCC).CGColor
        self.view.addSubview(contentView)
        
        //Constraints
        let heightConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[contentView]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kContentHeightMargin], views: ["contentView": contentView])
        for constraint in heightConstraints {
            constraint.priority = UILayoutPriorityDefaultHigh
        }
        self.view.addConstraints(heightConstraints)
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: kContentWidth))
        self.view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        
        self.view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    private func addContentSubviewConstraints() {
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[label]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kWidthMargin], views: ["label": titleLabel]))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[textView]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kWidthMargin], views: ["textView": messageTextView]))
        
        let lastButton = buttons.last!
        
        if buttons.count == 1 {
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[button]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kWidthMargin], views: ["button": lastButton]))
        } else {
            let firstButton = buttons.first!
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[firstButton]-space-[lastButton(==firstButton)]-margin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: ["margin": kWidthMargin, "space": kButtonHoriSpace], views: ["firstButton": firstButton, "lastButton": lastButton]))
        }
        
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[imageView]-imageSpace-[label]-labelSpace-[textView]-textViewSpace-[button]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kHeightMargin, "imageSpace": imageViewSpace, "labelSpace": titleLabelSpace, "textViewSpace": messageTextViewSpace], views: ["label": titleLabel, "textView": messageTextView, "button": lastButton, "imageView": imageView]))
        
        titleLabel.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical)
        messageTextView.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical)
    }
    
    private func setupImageView(style: CPAlertStyle) {
        
        var imageOption: UIImage? = nil
        
        switch style {
        case .Success:
            imageOption = CPAlertViewStyleKit.imageOfCheckmark
        case .Error:
            imageOption = CPAlertViewStyleKit.imageOfCross
        case .Warning:
            imageOption = CPAlertViewStyleKit.imageOfWarning
        case .Info:
            imageOption = CPAlertViewStyleKit.imageOfInfo
        case let .CustomImage(imageName):
            imageOption = UIImage(named: imageName)
        default:
            break
        }
        
        var imageWidth: CGFloat = 0
        var imageHeight: CGFloat = 0
        if let image = imageOption {
            self.imageView.image = image
            imageWidth = kImageViewWidth
            imageHeight = kImageViewHeight
            imageViewSpace = kVerticalGap
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        //Width and height constraints
        imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: imageWidth))
        imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: imageHeight))
    }
    
    private func setupTitleLabel(title: String?) {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = kTitleLines
        titleLabel.textAlignment = .Center
        titleLabel.text = title
        titleLabel.font = UIFont.systemFontOfSize(CPAlertViewController.titleFontSize)
        titleLabel.textColor = CPAlertViewController.titleColor
        titleLabel.backgroundColor = UIColor.clearColor()
        contentView.addSubview(titleLabel)
        
        if let aTitle = title where aTitle.isEmpty == false {
            titleLabelSpace = kVerticalGap
        }
    }
    
    private func setupMessageTextView(message: String?) {
        
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.textAlignment = .Center
        messageTextView.text = message ?? ""
        messageTextView.font = UIFont.systemFontOfSize(CPAlertViewController.messageFontSize)
        messageTextView.textColor = CPAlertViewController.messageColor
        messageTextView.editable = false
        messageTextView.selectable = false
        messageTextView.textContainerInset = UIEdgeInsetsZero
        messageTextView.fixedWidth = kContentWidth - 2 * kWidthMargin
        messageTextView.backgroundColor = UIColor.clearColor()
        contentView.addSubview(messageTextView)
        
        if messageTextView.text.isEmpty == false {
            messageTextViewSpace = kVerticalGap
        }
    }
    
    private func setupButtons(buttonTitle buttonTitle: String, otherButtonTitle: String?) {
        
        if let buttonTitle2 = otherButtonTitle where buttonTitle2.isEmpty == false {
            let button = createButton(buttonTitle2)
            contentView.addSubview(button)
            buttons.append(button)
        }
        
        let buttonTitle1 = buttonTitle.isEmpty ? "OK" : buttonTitle
        let button = createButton(buttonTitle1)
        contentView.addSubview(button)
        buttons.append(button)
    }
    
    private func createButton(title: String) -> UIButton {

        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = kButtonBaseTag + buttons.count
        button.layer.cornerRadius = 6.0
        button.layer.masksToBounds = true
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(CPAlertViewController.buttonFontSize)
        button.setTitleColor(CPAlertViewController.buttonTitleColor, forState: .Normal)
        button.setBackgroundImage(CPAlertViewController.buttonBGNomalColor.image(), forState: .Normal)
        button.setBackgroundImage(CPAlertViewController.buttonBGHighlightedColor.image(), forState: .Highlighted)
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //Height constraints
        button.addConstraint(NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: kButtonHeight))
        
        return button
    }
    
    @objc private func pressed(sender: UIButton) {
        
        let index = sender.tag - kButtonBaseTag
        close(clickedAtIndex:index)
    }
    
    private func close(clickedAtIndex index: Int) {
        
        if let action = userAction {
            action(buttonIndex: index)
        }
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.view.alpha = 0.0
            }) { (Bool) -> Void in
                
                self.contentView.removeFromSuperview()
                self.contentView = UIView()
                
                self.view.removeFromSuperview()
                
                //Releasing strong refrence of itself.
                self.strongSelf = nil
        }
    }
    
    private func animateAlert() {
        
        view.alpha = 0;
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.alpha = 1.0;
        })
        
        let previousTransform = self.contentView.transform
        self.contentView.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.0);
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.contentView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 0.0);
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.contentView.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.0);
                    }) { (Bool) -> Void in
                        UIView.animateWithDuration(0.1, animations: { () -> Void in
                            self.contentView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
                            }) { (Bool) -> Void in
                                
                                self.contentView.transform = previousTransform
                        }
                }
        }
    }
    
    //MARK: - API
    public func showSuccess(title title: String?, message: String?, buttonTitle: String = "OK", otherButtonTitle: String? = nil, action: UserAction? = nil) {
        show(title: title, message: message, style: .Success, buttonTitle: buttonTitle, otherButtonTitle: otherButtonTitle, action: action)
    }
    
    public func showError(title title: String?, message: String?, buttonTitle: String = "OK", otherButtonTitle: String? = nil, action: UserAction? = nil) {
        show(title: title, message: message, style: .Error, buttonTitle: buttonTitle, otherButtonTitle: otherButtonTitle, action: action)
    }
    
    public func showWarning(title title: String?, message: String?, buttonTitle: String = "OK", otherButtonTitle: String? = nil, action: UserAction? = nil) {
        show(title: title, message: message, style: .Warning, buttonTitle: buttonTitle, otherButtonTitle: otherButtonTitle, action: action)
    }
    
    public func showInfo(title title: String?, message: String?, buttonTitle: String = "OK", otherButtonTitle: String? = nil, action: UserAction? = nil) {
        show(title: title, message: message, style: .Info, buttonTitle: buttonTitle, otherButtonTitle: otherButtonTitle, action: action)
    }

    public func show(title title: String?, message: String?, style: CPAlertStyle = .None, buttonTitle: String = "OK", otherButtonTitle: String? = nil, action: UserAction? = nil) {
        
        let window: UIWindow = UIApplication.sharedApplication().keyWindow!
        window.addSubview(view)
        window.bringSubviewToFront(view)
        view.frame = window.bounds
        
        self.userAction = action
        
        setupContentView()
        setupImageView(style)
        setupTitleLabel(title)
        setupMessageTextView(message)
        setupButtons(buttonTitle: buttonTitle, otherButtonTitle: otherButtonTitle)
        addContentSubviewConstraints()
        
        animateAlert()
    }
}

private class CPAlertViewStyleKit : NSObject {
    
    struct Cache {
        static var imageOfCheckmark: UIImage?
        static var imageOfCross: UIImage?
        static var imageOfWarning: UIImage?
        static var imageOfInfo: UIImage?
    }
    
    //MARK: - Drawing Methods
    class func drawCheckmark() {
        
        let color0 = UIColor(red: 0.096, green: 0.580, blue: 0.057, alpha: 1.000)
        let color1 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        let oval2Path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 60, 60))
        color0.setFill()
        oval2Path.fill()
        
        let line2Path = UIBezierPath()
        line2Path.moveToPoint(CGPointMake(44.86, 21.68))
        line2Path.addLineToPoint(CGPointMake(26.08, 39.51))
        line2Path.addLineToPoint(CGPointMake(17.28, 30.55))
        line2Path.miterLimit = 4;
        
        line2Path.lineCapStyle = CGLineCap.Round;
        
        line2Path.usesEvenOddFillRule = true;
        
        color1.setStroke()
        line2Path.lineWidth = 4
        line2Path.stroke()
    }
    
    class func drawCross() {
    
        let color1 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let color = UIColor(red: 0.824, green: 0.017, blue: 0.102, alpha: 1.000)
        
        let oval1Path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 60, 60))
        color.setFill()
        oval1Path.fill()
        
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPointMake(18.45, 18.75))
        linePath.addLineToPoint(CGPointMake(41.85, 42.15))
        linePath.miterLimit = 4;
        
        linePath.lineCapStyle = CGLineCap.Round;
        
        linePath.usesEvenOddFillRule = true;
        
        color1.setStroke()
        linePath.lineWidth = 3
        linePath.stroke()
        
        let line2Path = UIBezierPath()
        line2Path.moveToPoint(CGPointMake(41.85, 18.45))
        line2Path.addLineToPoint(CGPointMake(18.45, 42.15))
        line2Path.miterLimit = 4;
        
        line2Path.lineCapStyle = CGLineCap.Round;
        
        line2Path.usesEvenOddFillRule = true;
        
        color1.setStroke()
        line2Path.lineWidth = 3
        line2Path.stroke()

    }
    
    class func drawWarning() {
        let color1 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let color3 = UIColor(red: 0.996, green: 0.788, blue: 0.068, alpha: 1.000)
        
        let oval1Path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 60, 60))
        color3.setFill()
        oval1Path.fill()
        
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPointMake(30, 33))
        linePath.addLineToPoint(CGPointMake(30, 13))
        linePath.miterLimit = 4;
        
        linePath.lineCapStyle = CGLineCap.Round;
        
        linePath.usesEvenOddFillRule = true;
        
        color1.setStroke()
        linePath.lineWidth = 4
        linePath.stroke()
        
        let oval3Path = UIBezierPath(ovalInRect: CGRectMake(27, 44, 6, 6))
        color1.setFill()
        oval3Path.fill()
    }
    
    class func drawInfo() {
        let color1 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let color4 = UIColor(red: 0.230, green: 0.480, blue: 0.858, alpha: 1.000)
        
        let oval1Path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 60, 60))
        color4.setFill()
        oval1Path.fill()
        
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPointMake(30, 27))
        linePath.addLineToPoint(CGPointMake(30, 47))
        linePath.miterLimit = 4;
        
        linePath.lineCapStyle = CGLineCap.Round;
        
        linePath.usesEvenOddFillRule = true;
        
        color1.setStroke()
        linePath.lineWidth = 4
        linePath.stroke()
       
        let oval3Path = UIBezierPath(ovalInRect: CGRectMake(27, 10, 6, 6))
        color1.setFill()
        oval3Path.fill()
    }
    
    //MARK: - images
    class var imageOfCheckmark: UIImage {
        if (Cache.imageOfCheckmark != nil) {
            return Cache.imageOfCheckmark!
        }
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(60, 60), false, 0)
        CPAlertViewStyleKit.drawCheckmark()
        Cache.imageOfCheckmark = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfCheckmark!
    }
    
    class var imageOfCross: UIImage {
        if (Cache.imageOfCross != nil) {
            return Cache.imageOfCross!
        }
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(60, 60), false, 0)
        CPAlertViewStyleKit.drawCross()
        Cache.imageOfCross = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfCross!
    }
    
    class var imageOfWarning: UIImage {
        if (Cache.imageOfWarning != nil) {
            return Cache.imageOfWarning!
        }
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(60, 60), false, 0)
        CPAlertViewStyleKit.drawWarning()
        Cache.imageOfWarning = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfWarning!
    }
    
    class var imageOfInfo: UIImage {
        if (Cache.imageOfInfo != nil) {
            return Cache.imageOfInfo!
        }
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(60, 60), false, 0)
        CPAlertViewStyleKit.drawInfo()
        Cache.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfInfo!
    }
}




