// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "OnLoad",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13)],
    products: [
        .library(name: "OnLoad", targets: ["OnLoad"])
    ],
    targets: [
        .target(name: "OnLoad")
    ]
)
