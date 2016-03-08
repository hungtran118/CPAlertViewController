#CocoaPods

##Making a CocoaPod

###Create Specs

1.  创建Specs或者拷贝已有的Specs文件，修改名称

    ```swift
    $ pod spec create CPAlertViewController
    ```

    生成CPAlertViewController.podspec

2.  编辑CPAlertViewController.podspec

    语法参考[Podspec Syntax Reference](https://guides.cocoapods.org/syntax/podspec.html)

3.  验证Specs文件书写是否正确

    ```swift
    $ pod lib lint
    ```

###Test

1.  创建一个工程 or 使用[Make a CocoaPod](https://guides.cocoapods.org/making/making-a-cocoapod.html)创建一个Demo工程

2.  Create a Podfile文件

    ```swift
    platform :ios, '8.0'
    use_frameworks!

    pod 'CPAlertViewController', :path => '~/Document/CPAlertViewController'(本地目录)
    or
    pod 'CPAlertViewController', :git => 'https://github.com/cp3hnu/CPAlertViewController.git'(github)
    ```

3.  Install

    ```Swift
    $ pod install
    ```

4.  Import module and test

    ```
    import CPAlertViewController
    ```

    Storyboard/Xib: Go to Utilities->Identity inspector->Module

###Release

1.  Tagging

    ```swift
    $ git add -A && git commit -m "Release 1.0.0"
    $ git tag 1.0.0
    $ git push --tags
    $ git tag
    ```

2.  Validation

    ```swift
    $ pod spec lint
    ```

3.  Register

    ```swift
    $ pod trunk register cp3hnu@gmail.com 'WeiZhao' --description='macbook pro'
    ```

    Verify the session by clicking the link in the verification email that has been sent to name@gmail.com

    ```swift
    $ pod trunk me
      - Name:     WeiZhao
      - Email:    cp3hnu@gmail.com
      - Since:    October 16th, 2015 01:37
      - Pods:
        - CPLoadingView
      - Sessions:
        - October 16th, 2015 01:37 - March 3rd, 20:02. IP: 211.142.224.130
        Description: iMac
        - February 28th, 06:05     -  July 5th, 06:09. IP: 192.161.61.132 
        Description: macbook pro
    ```

    Pushing

    ```Swift
    $ pod trunk push CPAlertViewController.podspec

    - Data URL: https://raw.githubusercontent.com/CocoaPods/Specs/fac6c60d85ee0ab9a1a5974d3fa11bcb3e6d5d70/Specs/CPAlertViewController/1.0.0/CPAlertViewController.podspec.json
      - Log messages:
        - February 28th, 06:12: Push for `CPAlertViewController 1.0.0' initiated.
        - February 28th, 06:12: Push for `CPAlertViewController 1.0.0' has been
        pushed (2.828579389 s)
    ```

###Validation

Create a project and Podfile

```swift
platform :ios, '8.0'
use_frameworks!

pod 'CPAlertViewController'
```

###Reference

*   [CocoaPod](https://cocoapods.org/)
*   [Creating Your First CocoaPod](http://code.tutsplus.com/tutorials/creating-your-first-cocoapod--cms-24332)



