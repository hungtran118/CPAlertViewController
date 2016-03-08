Pod::Spec.new do |s|
  s.name             = "CPAlertViewController"
  s.version          = "1.0.2"
  s.summary          = "CPAlertViewController is custom animated Alert View Controller. Written in Swift."
  s.homepage         = "https://github.com/cp3hnu/CPAlertViewController"
  s.license          = 'MIT'
  s.author           = { "Wei Zhao" => "cp3hnu@gmail.com" }
  s.source           = { :git => "https://github.com/cp3hnu/CPAlertViewController.git", :tag => s.version }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Classes/*.swift'
end
