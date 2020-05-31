// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Transfiguration",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "Transfiguration",
            targets: ["Transfiguration"])
    ],
    targets: [
        .target(
            name: "Transfiguration",
            dependencies: [])
    ],
    swiftLanguageVersions: [.v5]
)
