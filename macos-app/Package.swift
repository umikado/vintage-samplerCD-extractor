// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AkaiBatchExtractor",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "AkaiBatchExtractor", targets: ["AkaiBatchExtractor"])
    ],
    targets: [
        .executableTarget(
            name: "AkaiBatchExtractor",
            path: "Sources"
        )
    ]
)
