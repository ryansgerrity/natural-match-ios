// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NaturalMatch",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "NaturalMatch",
            targets: ["NaturalMatch"]),
    ],
    dependencies: [
        // Add your dependencies here
    ],
    targets: [
        .target(
            name: "NaturalMatch",
            dependencies: []),
        .testTarget(
            name: "NaturalMatchTests",
            dependencies: ["NaturalMatch"]),
    ]
) 