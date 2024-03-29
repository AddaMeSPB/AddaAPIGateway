// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "AddaAPIGateway",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.62.1"),
        .package(url: "https://github.com/vapor/jwt.git", from: "4.2.0"),
        .package(url: "https://github.com/OpenKitten/MongoKitten.git", from: "6.7.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.2.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "JWT", package: "jwt"),
                .product(name: "MongoKitten", package: "MongoKitten"),
                .product(name: "Leaf", package: "leaf"),
            ],
            swiftSettings: [
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)


