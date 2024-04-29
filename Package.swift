// swift-tools-version: 5.10

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "VAYogaKit",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .library(
            name: "VAYogaKit",
            targets: ["VAYogaKit"]
        ),
        .library(
            name: "VAYogaKitMacro",
            targets: ["VAYogaKitMacro"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/facebook/yoga.git", exact: "3.0.4"),
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
    ],
    targets: [
        .macro(
            name: "VAYogaKitMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        .target(name: "VAYogaKitMacro", dependencies: ["VAYogaKitMacros"]),
        .target(
            name: "VAYogaKit",
            dependencies: [
                .product(name: "yoga", package: "yoga"),
            ], 
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "VAYogaKitTests",
            dependencies: ["VAYogaKit"]
        ),
    ]
)
