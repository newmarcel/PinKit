// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "PinKit",
    platforms: [.iOS(.v13), .macOS(.v10_14)],
    products: [
        .library(name: "PinKit", targets: ["PinKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "PinKit", dependencies: []),
    ]
)
