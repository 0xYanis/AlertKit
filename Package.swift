// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlertKit",
    platforms: [.iOS(.v15), .macOS(.v13), .macCatalyst(.v15), .tvOS(.v15), .watchOS(.v8)],
    products: [
        .library(
            name: "AlertKit",
            targets: ["AlertKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AlertKit",
            dependencies: []),
        .testTarget(
            name: "AlertKitTests",
            dependencies: ["AlertKit"])
    ]
)
