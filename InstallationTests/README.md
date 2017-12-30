# Installation Test

## Carthage

```shell
cd ./Carthage
carthage update
```

## Cocoapods

### iOS

```shell
cd ./Cocoapods/Cocoapods-iOS
pod update
open Cocoapods-iOS.xcworkspace
# -> Build by Xcode
```

### macOS

```shell
cd ./Cocoapods/Cocoapods-macOS
pod update
open Cocoapods-macOS.xcworkspace
# -> Build by Xcode
```

## Swift Package Manager

```shell
cd ./SwiftPM
swift package update
swift build
```
