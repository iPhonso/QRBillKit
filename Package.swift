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
            url: "https://github.com/iPhonso/QRBillKit/blob/main/QRBillKit.zip",
            checksum: "7e336298db62ff7c35d6563dba8c9a8eac2d91a72cd9209c3a1b808c79d00f05"
        )
    ]
)
