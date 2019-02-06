// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSchema",
    products: [
        .library(name: "SwiftSchema", targets: ["SwiftSchema"])
    ],
    dependencies: [],
    targets: [
        .target(name: "SwiftSchema", dependencies: []),
        .testTarget(name: "SwiftSchemaTests", dependencies: ["SwiftSchema"])
    ]
)
