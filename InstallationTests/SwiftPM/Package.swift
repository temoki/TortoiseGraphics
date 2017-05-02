// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "SwiftPM",
    dependencies: [
        .Package(url: "https://github.com/temoki/TortoiseGraphics.git", majorVersion: 0)
    ]
)
