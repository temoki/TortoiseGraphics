// swift-tools-version:4.0.0

import PackageDescription

let package = Package(
    name: "SwiftPM",
    dependencies: [
        .package(url: "https://github.com/temoki/TortoiseGraphics.git", .branch("develop")),
    ],
    targets: [
        .target(name: "SwiftPM", dependencies: ["TortoiseGraphics"], path: "Sources"),
    ]
)
