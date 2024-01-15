# Curo
## Authors and Acknowledgement 
John Ho, William Ibarra, Hajra Rizvi 

![PROG31632_iOS_Project_Proposal](https://github.com/ibarraw/CuroGroupProject/assets/84588576/f6a48ea3-91c9-45a3-b543-7d1183f23a2c)

## Description
Curo is a mobile iOS application designed to keep track of assignments, tasks and deadlines. 
The application creates reminders, triggers notifications, and employs authentication to ensure privacy and security. 

## Project Status
This project is no longer supported or maintained. 

## Installation 
1. Download project
2. Install Cocoa Pods
3. Build and run project on iPhone 13 Pro  

### Installing Cocoa Pods
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
 
### Build and run Project on iPhone 13 Pro
1. Navigate to project root in Finder
2. Open Curo.xcworkspace
3. Build and Run

## Technologies Used 
### CocoaPods  
CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects and provides a centralized way for developers to manager external libraries called "pods". 
CocoaPods was employed in this project to install external libraries and modules. 

### EventKit 
EventKit is a framework provided by Apple for use in its iOS and macOS SDKs. 
This development allows applications to manipulate calendar events and reminders. 
The kit enabled the application to create, retrieve, edit and delete calendar events. 

### Firebase Google Authentication 
Firebase Authentication is a service provided by Firebase, a platform owned by Google. 
It enables developers to authenticate users without the need to implement their own authentication systems. 
This includes creation and storage of credentials. 

### SQLite3 
A software library that provides a relational database management system. 
It's an embedded, serverless and self-contained database used within our application to store details regarding assignments, tasks and deadlines. 
