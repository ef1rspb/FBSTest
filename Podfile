source "https://github.com/CocoaPods/Specs.git"

inhibit_all_warnings!
platform :ios, '9.0'
use_frameworks!

target 'FBSTest' do
  pod 'TableKit'
  pod 'SwiftLint'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'KeychainAccess'
  
  target 'FBSTestTests' do
    inherit! :search_paths
    pod 'Quick'
  end

  target 'FBSTestUITests' do
    inherit! :search_paths
  end

end
