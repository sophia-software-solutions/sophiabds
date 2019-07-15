
use_frameworks!
platform :ios, '10.0'

target 'PostingProject' do
  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'SwiftDate'
  pod 'SpringIndicator'
  pod 'PullToRefresher'
  #  pod 'SWXMLHash'
  #  pod 'SwiftyXMLParser'
  #  pod 'PieCharts'
  #  pod 'DropDown'
  #  pod 'FontAwesome.swift'
  pod 'GrowingTextView', '0.6.1'
  pod 'GoogleSignIn'
  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'AccountKit'
  
end

target 'PostingProjectTests' do
  inherit! :search_paths
end

target 'PostingProjectUITests' do
  inherit! :search_paths
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    # Workaround for CocoaPods issue: https://github.com/CocoaPods/CocoaPods/issues/7606
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
    
    # Do not need debug information for pods
    config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
    
    # Disable Code Coverage for Pods projects - only exclude ObjC pods
    config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
    config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = ['$(FRAMEWORK_SEARCH_PATHS)']
    
    config.build_settings['SWIFT_VERSION'] = '4.2'
  end
end

