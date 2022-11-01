// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XcapAppKit",
    platforms: [.iOS(.v11), .macOS(.v11)],
    products: [
        .library(name: "XcapAppKit", targets: ["XcapAppKit"]),
    ],
    targets: [
        .target(name: "XcapAppKit"),
        .testTarget(name: "XcapAppKitTests", dependencies: ["XcapAppKit"]),
    ]
)
