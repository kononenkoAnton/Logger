# Uncomment the next line to define a global platform for your project
platform :macos, '11.0'

target 'Logger' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Introspect'

  target 'LoggerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LoggerUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|

            post_install_dt_toolchain_dir(config)
        end
    end
end


def post_install_dt_toolchain_dir(config)
  # Fix for Error 'DT_TOOLCHAIN_DIR cannot be used to evaluate LIBRARY_SEARCH_PATHS, use TOOLCHAIN_DIR instead' in Xcode 15
  # https://github.com/CocoaPods/CocoaPods/issues/12012
  xcconfig_path = config.base_configuration_reference.real_path
  xcconfig = File.read(xcconfig_path)
  xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
  File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
end
