# Curo
Group iOS project

Install Cocoa Pods
1. Navigate to project root and open terminal
2. run: pod init
3. open newly created Podfile in text editor
4. delete the contents of Podfile and replace with the following: 
```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Curo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

# Pods for Curo
  pod 'FirebaseAnalytics'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'Firebase/Core'

end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
         end
    end
  end
end
```
5. save and close Podfile
6. return to terminal and run: pod install
 
Build and run Project on iPhone 13 Pro
1. Navigate to project root in Finder
2. Open Curo.xcworkspace
3. Build and Run

