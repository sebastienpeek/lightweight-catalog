// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "apple-data-package",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "apple-data-package",
            targets: ["apple-data-package"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "apple-network-package", path: "apple-network-package")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "apple-data-package",
            dependencies: ["apple-network-package"]),
        .testTarget(
            name: "apple-data-packageTests",
            dependencies: ["apple-data-package"]),
    ]
)
