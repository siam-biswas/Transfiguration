// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Transfiguration",
    products: [
        .library(
            name: "Transfiguration",
            targets: ["Transfiguration"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Transfiguration",
            dependencies: []),
        .testTarget(
            name: "TransfigurationTests",
            dependencies: ["Transfiguration"]),
    ]
)
