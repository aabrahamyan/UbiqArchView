#
# Be sure to run `pod lib lint UbiqArchView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UbiqArchView'
  s.version          = '0.0.6'
  s.summary          = 'UbiqArchView is a state related animatable view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
UbiqArchView is an apple App Store like animation, that shows circular progress of ongoing tasks in different states.
                       DESC

  s.homepage         = 'https://github.com/aabrahamyan/UbiqArchView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Armen Abrahamyan' => 'abrahamyan.armen@gmail.com' }
  s.source           = { :git => 'https://github.com/aabrahamyan/UbiqArchView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/VvV_Spawn'

  s.ios.deployment_target = '9.3'

  s.source_files = 'UbiqArchView/UbiqArchView/source/**/*'
  
  # s.resource_bundles = {
  #   'AAPhotoLibrary' => ['AAPhotoLibrary/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
