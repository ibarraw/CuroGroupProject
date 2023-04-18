# Curo
Group iOS project

Install Cocoa Pods
1. Navigate to project root and open terminal
2. run: pod init
3. open newly created Podfile in text editor
4. copy and paste the following between "# Pods for Curo" and "end"
```
pod 'FirebaseAnalytics'
pod 'FirebaseAuth'
pod 'FirebaseFirestore'
pod 'Firebase/Core'
```
5. save and close Podfile
6. return to terminal and run: pod install
 
Build and run Project on iPhone 13 Pro
1. Navigate to project root in Finder
2. Open Curo.xcworkspace
3. Build and Run

## Troubleshooting

If you receive an error that states: "Signing for 'Curo' requires a development team. Select a development team in the Signing & Capabilities editor".

Then perform the following:

1. Update Podfile (file created at step 2 after 'pod init') with the following appended AFTER the pod package declartion from step #4: 
*Note, a new clone may be needed the first time this is ran to clear previous errors*
```
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
