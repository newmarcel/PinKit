// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "PinKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "PinKit",
            targets: ["PinKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/newmarcel/RecorderSession.git", .upToNextMajor(from: "1.0.2")),
    ],
    targets: [
        .target(
            name: "PinKit",
            dependencies: []
        ),
        .testTarget(
            name: "PinKitTests",
            dependencies: [
                "PinKit",
                "RecorderSession"
            ],
            resources: [
                .copy("Resources/Cassettes.bundle"),
            ]
        ),
    ]
)
