// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "TortoiseGraphics",
    targets: [
        .target(name: "TortoiseGraphics", path: "Sources"),
        .testTarget(name: "TortoiseGraphicsTests", dependencies: ["TortoiseGraphics"], path: "Tests")
    ],
    swiftLanguageVersions: [5]
)
