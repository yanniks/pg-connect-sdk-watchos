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
            targets: ["ConnectSDKWatch", "ConnectSDKWatchDependencies"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.16.0"),
        .package(url: "https://github.com/unrelentingtech/SwiftCBOR.git", from: "0.4.4")
    ],
    targets: [
        .binaryTarget(
            name: "ConnectSDKWatch",
            url: "https://dl.cloudsmith.io/CujHIwqxWVjq8tLK/proglove/markconnectiossdk-dev/raw/versions/2.0.0/ConnectSDKWatch-2.0.0.xcframework.zip",
            checksum: "1adf696be4c35a62b54772efa92f06be0a7a6b0b3d571c944eadbc9956b40f9b"),
        .target(
            name: "ConnectSDKWatchDependencies",
            dependencies: [
                "SwiftCBOR",
                .product(name: "SwiftProtobuf", package: "swift-protobuf")
            ],
            path: "Sources/ConnectSDK"
        )
    ]
)
