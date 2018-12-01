source "https://github.com/CocoaPods/Specs.git"
source "https://github.com/TouchInstinct/Podspecs.git"

inhibit_all_warnings!
platform :ios, '9.0'
use_frameworks!

target 'FBSTest' do
  pod 'LeadKit'
  pod 'LeadKitAdditions'
  pod 'RealmSwift'
  pod 'RxRealm'
  pod 'SwiftLint'
  
  target 'FBSTestTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
    pod 'RxBlocking'
    pod 'RxNimble'
    pod 'RxTest'
  end

  target 'FBSTestUITests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
    pod 'RxBlocking'
    pod 'RxNimble'
    pod 'RxTest'
  end

end
