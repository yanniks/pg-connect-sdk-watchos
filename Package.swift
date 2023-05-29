// swift-tools-version: 5.5
import PackageDescription

let package = Package(
    name: "ConnectSDK",
    platforms: [
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "ConnectSDKWatch",
            targets: ["ConnectSDKWatch", "Protobuf"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.16.0")
    ],
    targets: [
        .binaryTarget(
            name: "ConnectSDKWatch",
            url: "https://dl.cloudsmith.io/CujHIwqxWVjq8tLK/proglove/markconnectiossdk-dev/raw/versions/1.8.0/ConnectSDKWatch-1.8.0.xcframework.zip",
            checksum: "688267076362711b0cf17242928c60325af59a64388d2531c6177cf45bf368e6"),
        .target(
            name: "Protobuf",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf")
            ],
            path: "Sources/ConnectSDK"
        )
    ]
)
