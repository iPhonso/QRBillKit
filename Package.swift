// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QRBillKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "QRBillKit",
            targets: ["QRBillKit"]
        )
    ],
    targets: [
        // .binaryTarget(name: "QRBillKit", path: "QRBillKit.zip"),
        .binaryTarget(
            name: "QRBillKit",
            url: "https://github.com/iPhonso/QRBillKit/raw/refs/heads/main/QRBillKit.zip",
            checksum: "ef7c53ae011eff0f679f24d0b4db496f0ec631250b5eadcb43b8045d6af84c61"
        )
    ]
)
