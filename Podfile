platform :ios, '9.0'
use_frameworks!
source 'https://github.com/artsy/Specs.git'
source 'https://github.com/CocoaPods/Specs.git'

def commonPods
  pod 'ObjectMapper'

  pod 'PromiseKit'
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'Log'

  pod 'SteviaLayout'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxGesture'
  pod 'RealmSwift'
  pod 'XLActionController'
  pod 'Whisper'
  pod 'ReachabilitySwift'
  pod 'Material'
  pod 'SwiftyTimer'
end

target "DemoTests" do
  commonPods
  pod 'OHHTTPStubs' # Default subspecs, including support for NSURLSession & JSON etc
  pod 'OHHTTPStubs/Swift'
end

target "Demo" do
  commonPods
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    phase_name = 'Headers'
    target.build_phases.each do |phase|
      if (phase.display_name.include? phase_name)
        target.build_phases.unshift(phase).uniq! unless target.build_phases.first == phase
      end
    end

    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
    if target.to_s.include? 'Pods'
      target.build_configurations.each do |config|
        if !config.to_s.include? 'Debug'
          config.build_settings['CODE_SIGN_IDENTITY[sdk=iphoneos*]'] = 'iPhone Distribution'
        end
      end
    end
  end
end

