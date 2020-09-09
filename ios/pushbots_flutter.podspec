#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint pushbots_flutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'pushbots_flutter'
  s.version          = '1.0.2'
  s.summary          = 'PushBots flutter SDK'
  s.description      = 'PushBots is a scalable push notification system for mobile applications that helps save time and effort to effectively communicate with your users. We provide native SDKs (Android, iOS, and Phonegap), REST API, API clients(PHP, Python, NodeJS and dotNET) and an online dashboard to manage and send your push notifications. We also provide analytics, push scheduling and Twitter integration.'
  s.homepage         = 'https://pushbots.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'PushBots' => 'info@pushbots.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Pushbots', '2.5.0'
  s.platform = :ios, '9.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end