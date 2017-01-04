# UbiqArchView
'UbiqArchView' is an apple App Store like animation, that shows circular progress of ongoing tasks in different states

[![CI Status](http://img.shields.io/travis/Armen Abrahamyan/AAPhotoLibrary.svg?style=flat)](https://travis-ci.org/Armen Abrahamyan/UbiqArchView)
[![Version](https://img.shields.io/cocoapods/v/UbiqArchView.svg?style=flat)](http://cocoapods.org/pods/UbiqArchView)
[![License](https://img.shields.io/cocoapods/l/UbiqArchView.svg?style=flat)](http://cocoapods.org/pods/UbiqArchView)
[![Platform](https://img.shields.io/cocoapods/p/UbiqArchView.svg?style=flat)](http://cocoapods.org/pods/UbiqArchView)



Checkout on [Appetize.io](https://appetize.io/embed/px9jyf50gf6yqdzaxz7n9n2nq8).


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
XCode8+
Minimum Deployment Target iOS 9.3

## Installation

UbiqArchView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UbiqArchView"
```

## Manual Installation
Copy UbiqArchView.swift into your project

## Usage
You can initialize it from XIB file as well as manually:
```swift    
let ubiqArchView = UbiqArchView(frame: CGRect(origin: point, size: boundSize))
```
Update default parameters by setting them externaly:
```swift
//Add symbol size
ubiqArchView.symbolSize = 20
// Width of inner static circle and broken animatable arch circle
ubiqArchView.archlineWidth = 3
// Progress circle line width
ubiqArchView.progressLineWidth = 6
// Pause symbol thickness
ubiqArchView.pauseSymbolThickness = 4
// Vertical distance between pause symbols and circle
ubiqArchView.pauseSymbolTopMultiplicationFactor = 4
// Horizontal distance between two pause symbols
ubiqArchView.pauseSymbolsDistance = 3
```
Modify state when your process/task is pending, inprogress or finished
```swift
// Sets Pending state
ubiqArchView.setStatePending()
// Sets In Progress state
ubiqArchView.setStateInProgress()
// Sets Paused state
ubiqArchView.setStateInProgressWithPaused()
// Sets state Normal
ubiqArchView.setStateNormal()
```
Modify animatable progress by updating 'progress' property
```swift
ubiqArchView.progress = 0.7
```
Check or change process state by accessing or modifying ubiqState property
```swift
ubiqState = .pending
```

## Whats New ?

* Added pause state support
* Added enum for handling state more correctly

# License

UbiqArchView is available under the MIT license. See the LICENSE file for more info.

## Author
Armen Abrahamyan, abrahamyan.armen@gmail.com

[Twitter](https://twitter.com/VvV_Spawn)


