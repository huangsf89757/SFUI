#
# Be sure to run `pod lib lint SFUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SFUI'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SFUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hsf89757/SFUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hsf89757' => 'shanfeng.huang@microtechmd.com' }
  s.source           = { :git => 'https://github.com/hsf89757/SFUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  s.swift_version = '5.0'

  s.source_files = 'SFUI/Classes/**/*'
  
   s.resource_bundles = {
     'SFUI' => ['SFUI/Assets/**/*']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  
  # --- 依赖 --- #
  # Basic
  s.dependency 'SFExtension',                 '~> 0.1.0'
  s.dependency 'SFBase',                      '~> 0.1.0'
  # Server
  s.dependency 'SFLogger',                    '~> 0.1.0'
  # Third
  s.dependency 'SnapKit',                     '~> 5.6.0'
  s.dependency 'SnapKitExtend',               '~> 1.1.0'
  s.dependency 'Reusable',                    '~> 4.1.2'
  s.dependency 'IQKeyboardManagerSwift',      '~> 6.5.16'
  
end

