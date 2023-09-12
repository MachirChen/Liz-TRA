# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Liz-TRA' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Liz-TRA
  pod 'SnapKit'
  pod 'FirebaseAnalytics'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestoreSwift'
  pod 'FirebaseFirestore'
  pod 'GoogleSignIn'
  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'FirebaseStorage'
  pod 'IQKeyboardManagerSwift'
  pod 'SVProgressHUD'
  pod 'JGProgressHUD'
end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
  end
 end
end