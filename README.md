# iOS-Functionality-Project
Nick Brandt

## Project Description
Using Apple's Swift language, this application will offer an exploration of some of Apple's iOS operating system's quintessential APIs, core libraries and fundemental device hardware capabilities. 

## Minimum Hardware Requirements
Some of the functionality within this project will access hardware features which are only available on the iPhone 7 or newer devices. Also, any device or simulator intended for testing may need to be running iOS 10.0 or a more recent version of the operating system.

## Goals
This project essentially focuses on the CPU usage and memory requirements of utilizing standard iOS device features. Along with using the ```UIKit``` module for handling the bulk of the user interface work, the various classes call upon a myriad of iOS APIs that are within the ```Darwin```, ```Foundation```, and ```Cocoa``` modules. The project will contain a central class, the ```MainDirectory``` class. This class is the intial view presented upon loading the application, and acts as a navigation center where a user can select a given ```UITableViewCell``` in a ```UITableView``` and navigate to one of four demonstrative classes: 

* __Gyroscope:__ this class implements methods to begin reading gyroscopic input and a method to stop reading said input. The shifts in the [x,y,z] coordinates of the device will be outputted in real time to the user interface. This class will also display the CPU and memory impact that these methods are having on the device in real time.

* __Haptic Feedback:__ this class utilizes buttons for using the device's haptic feedback engine to generate vibrations on button press. There will be a button for each intensity of feedback. This class will also display the CPU and memory impact that a button press will have on the device in real time.

* __Barometer:__ this class reads the device's barometer/altimeter and displays the input in real time to the user interface. This class will also display the CPU and memory impact that this class is having on the device in real time.

* __Accelerometer:__ this class implements methods for reading the device's accelerometer data and outputting the data in real time to the user interface. This class will also display the CPU and memory impact that this class is having on the device in real time.

## Demonstration Clips
Here are some clips of an actual device being recorded using QuickTime to demonstrate each class: 







