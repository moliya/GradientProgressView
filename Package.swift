// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GradientProgressView",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(name: "GradientProgressView", targets: ["GradientProgressView"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "GradientProgressView", dependencies: [], path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)
