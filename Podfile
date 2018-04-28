# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MTG Cards' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MTG Cards
  pod 'Kingfisher'

  target 'MTG CardsTests' do
    inherit! :search_paths
    pod 'UITestKit'
  end

end

# Post Installation Tasks
post_install do |installer|
  puts "Running Post-Installation Tasks..."

  # Since This project is Swift 4, we need to explicitly state SWIFT VERSION for pods written using Swift 3.
  swift3Pods = ['Kingfisher', 'UITestKit']

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO' # Disables Bitcode for every Pod
      config.build_settings.delete('DEBUG_INFORMATION_FORMAT') # Enabling Debug Symbol Generation for every Pod
      config.build_settings['SWIFT_VERSION'] = '3.0' if swift3Pods.include? target.name
    end
  end

end
