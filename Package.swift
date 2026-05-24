// swift-tools-version: 6.2

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "VAYogaKit",
    platforms: [.iOS(.v13)],
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
        .package(url: "https://github.com/facebook/yoga.git", exact: "3.2.1"),
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
        .target(
            name: "VAYogaKitMacro",
            dependencies: ["VAYogaKitMacros"]
        ),
        .target(
            name: "VAYogaKit",
            dependencies: [
                .product(name: "yoga", package: "yoga"),
            ],
            swiftSettings: [
                .defaultIsolation(MainActor.self),
            ]
        ),
        .testTarget(
            name: "VAYogaKitTests",
            dependencies: ["VAYogaKit"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
