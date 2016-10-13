# UbiqArchView
'UbiqArchView' is an apple App Store like animation, that shows circular progress of ongoing tasks in different states

[![CI Status](http://img.shields.io/travis/Armen Abrahamyan/AAPhotoLibrary.svg?style=flat)](https://travis-ci.org/Armen Abrahamyan/AAPhotoLibrary)
[![Version](https://img.shields.io/cocoapods/v/AAPhotoLibrary.svg?style=flat)](http://cocoapods.org/pods/AAPhotoLibrary)
[![License](https://img.shields.io/cocoapods/l/AAPhotoLibrary.svg?style=flat)](http://cocoapods.org/pods/AAPhotoLibrary)
[![Platform](https://img.shields.io/cocoapods/p/AAPhotoLibrary.svg?style=flat)](http://cocoapods.org/pods/AAPhotoLibrary)



Checkout on [Appetize.io](https://appetize.io/embed/px9jyf50gf6yqdzaxz7n9n2nq8).


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
XCode8+
Minimum Deployment Target iOS 10.0

## Installation

UbiqArchView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UbiqArchView"
```

## Manual Installation
Copy UbiqArchView.swift into your project

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
```
Modify state when your process/task is pending, inprogress or finished
```swift
// Sets Pending state
ubiqArchView.setStatePending()
// Sets In Progress state
ubiqArchView.setStateInProgress()
// Sets state Normal
ubiqArchView.setStateNormal()
```


