#
# Be sure to run `pod lib lint WSLog.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WSLog'
  s.version          = '0.1.0'
  s.summary          = '日志管理'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    日志插件，用于管理日志

                       DESC

  s.homepage         = 'https://github.com/wws19125/WSLog'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '王的世界' => 'wws19125@126.com' }
  s.source           = { :git => 'https://github.com/wws19125/WSLog.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WSLog/**/*'
  
  # s.resource_bundles = {
  #   'WSLog' => ['WSLog/Assets/*.png']
  # }

  #s.public_header_files = 'WSLog/WSLog.h','WSLog/WSLogMicro.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.6.3'
end
