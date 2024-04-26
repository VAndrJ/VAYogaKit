// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "VAYogaKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "VAYogaKit",
            targets: ["VAYogaKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/facebook/yoga.git", exact: "3.0.4"),
    ],
    targets: [
        .target(
            name: "VAYogaKit",
            dependencies: [
                .product(name: "yoga", package: "yoga"),
            ]
        ),
        .testTarget(
            name: "VAYogaKitTests",
            dependencies: ["VAYogaKit"]
        ),
    ]
)
