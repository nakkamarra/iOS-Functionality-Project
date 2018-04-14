# iOS-Functionality-Project
Nick Brandt

## Project Description
Using Apple's Swift language, this application will offer an exploration of some of Apple's iOS operating system's quintessential APIs, core libraries and fundemental device hardware capabilities. 

## Minimum Hardware Requirements
Some of the functionality within this project will access hardware features which are only available on the iPhone 7 or newer devices. Also, any device or simulator intended for testing may need to be running iOS 10.0 or a more recent version of the operating system.

## Goals
This project essentially focuses on the CPU usage and memory requirements of utilizing standard iOS device features. Along with using the ```UIKit``` module for handling the bulk of the user interface work, the various classes call upon a myriad of iOS APIs that are within the ```CoreMotion```, ```Foundation```, and ```Cocoa``` modules. The project will contain a central class, the ```MainDirectory``` class. This class is the intial view presented upon loading the application, and acts as a navigation center where a user can select a given ```UITableViewCell``` in a ```UITableView``` and navigate to one of four demonstrative classes: 

* __Gyroscope:__ this class implements methods to begin reading gyroscopic input and a method to stop reading said input. The rotation values in the [x,y,z] dimensions of the device will be outputted in real time to the user interface. This class also makes use of the built in animation engine that is part of ```UIKit``` to animate a simple green rectangular ```UIView```. The x and y rotation values are captured at a rate of 15Hz, and the values are used in a translation animation of the green rectangle, where the x and y values are multiplied by an offset of the rectangle's size in the 2D plane (e.g. x rotation is multiplied by half of the rectangle's width, y rotation is multiplied by half of the rectangle's height). The offset value generated by this operation increases with the intensity of the rotation of the device, so the larger the rotation values, the farther the rectangle will animate from its initial location. This class also displays the CPU and memory impact that these methods are having on the device in real time by using an instance of the SystemView.

* __Haptic Feedback:__ this class utilizes instances of the ```UIButton``` class for using the device's haptic feedback engine to generate vibrations on button press. There will be a button for each degree of intensity of haptic feedback. Each button intensity triggers an animated simulation of a collision between two ```UIView```s. The feedback occurs upon the views' collision to simulate the sense of physical collision. This class also displays the CPU and memory impact that a button press will have on the device in real time by using an instance of the SystemView.

* __Barometer:__ this class reads the device's barometer/altimeter and displays the input in real time to the user interface. Two ```UILabel```s will be used to display the output data from the ```CoreMotion``` Altimeter, and the readings for altitude measure two important changes: 
    * the relative altitude change since the start of the input stream
    * the measurement of atmospheric pressure, measured in kilopascals

* __Accelerometer:__ this class implements methods for reading the device's accelerometer data and outputting the data in real time to the user interface. The ```CoreMotion```'s Accelerometer output measures the device's velocity as relative gravitational force along one of the device's axes. Changes in velocity in the [x,y,z] dimensions are measured as a function of the gravitational acceleration toward Earth, where the value 1.0 represents the standard _g_ value (9.8 m/s). For example, if the device were to be dropped from high up, the accelerometer would read the gravitational force of freefall as 1 along one of its axes. ```UILabel```s display these readings, which are accessed at a rate of 10Hz, by multiplying the accelerometer data values by _g_. This class also displays the CPU and memory impact that a button press will have on the device in real time by using an instance of the SystemView. 

* __Magnetometer:__ this class makes use of the device's built in magnetometer to display an estimation of which direction the top of the device is facing. The ```CoreMotion```'s Magnetometer output measures the [x,y,z] measurements of the device's magnetic field. Due to the fact that this data is raw data and does not account for the possible magnetic forces from within or on the device, these values may not be entirely precise. This class outputs the x, y, and z values to ```UILabel```s and updates these values and the polar estimation's value at a rate of 15Hz. This class also displays the CPU and memory impact that a button press will have on the device in real time by using an instance of the SystemView. 

* __SystemView__: this class is designed to be a subclass of the ```UIView``` class, and is strictly tasked with getting the device's CPU and memory usage at a given time. The SystemView will have two ```UILabel``` subviews which will be respectively updated each time these operating system values are referenced.

## Demonstration Clips
Here are some clips of an actual device being recorded using QuickTime to demonstrate each class: 







