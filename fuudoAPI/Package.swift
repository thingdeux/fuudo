// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "fuudoAPI",
    // I'd like to use Async/Await so I'm going to restrict this Package to iOS 13+
    // Certainly not necessary to do so - but it's going to make my life just a bit easier w/ speed.
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "fuudoAPI",
            targets: ["fuudoAPI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/apple/swift-collections", from: "1.0.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "fuudoAPI",
            dependencies: [
                .product(name: "OrderedCollections", package: "swift-collections")
            ]),
        .testTarget(
            name: "fuudoAPITests",
            dependencies: ["fuudoAPI"]),
    ]
)