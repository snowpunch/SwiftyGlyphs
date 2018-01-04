// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyGlyphs",
    products: [
        .library(name: "SwiftyGlyphs", targets: ["SwiftyGlyphs"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SwiftyGlyphs", dependencies: [], path: "Sources"),
    ]
)
