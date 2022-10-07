#
# Be sure to run `pod lib lint YFNetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YFNetwork'
  s.version          = '0.1.0'
  s.summary          = '基于moya的网络请求封装,支持缓存配置'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!


  s.homepage         = 'https://github.com/yonfong/YFNetwork'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yonfong' => 'yongfongzhang@163.com' }
  s.source           = { :git => 'https://github.com/yonfong/YFNetwork.git', :tag => s.version.to_s }
  

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  
  # 默认的使用模块
  s.default_subspec = 'Core'
    
  s.subspec 'Core' do |ss|
        ss.source_files = 'YFNetwork/Classes/Core'
        ss.dependency 'Moya'
  end
  
  s.subspec 'ResponseCache' do |ss|
        ss.source_files = 'YFNetwork/Classes/ResponseCache'
        ss.dependency 'YFNetwork/Core'
        ss.dependency 'MoyaCache'
  end

end
