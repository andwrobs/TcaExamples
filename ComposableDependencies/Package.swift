// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Dependencies",
    platforms: [
      .iOS(.v15)
    ],
    products: [
      .library(name: "ComposableAppContext", targets: ["ComposableAppContext"]),
      .library(name: "ComposableCodable", targets: ["ComposableCodable"]),
      .library(name: "ComposableSQLite", targets: ["ComposableSQLite"]),
    ],
    dependencies: [
      .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.14.1"),
      .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.49.1")
    ],
    targets: [
      
      /* ComposableAppContext */
      .target(
        name: "ComposableAppContext",
        dependencies: [
          .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
        ]
      ),
      
      /* ComposableCodable */
      .target(
        name: "ComposableCodable",
        dependencies: [
          .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        ]
      ),
      
      /* ComposableSQLite */
      .target(
        name: "ComposableSQLite",
        dependencies: [
          .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
          .product(name: "SQLite", package: "SQLite.swift"),
        ]
      ),
      
    ]
)
