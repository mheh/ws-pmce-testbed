// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "echo-server",
    platforms: [
       .macOS(.v10_15),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-nio",
            from: "2.0.0"
        ),
        .package(url:"https://github.com/jhoughjr/websocket-kit.git", branch:"main"),

    ],
    targets: [
        .executableTarget(
            name: "Server",
            dependencies: [
                .product(
                    name: "NIO",
                    package: "swift-nio"
                ),
                .product(
                    name: "NIOHTTP1",
                    package: "swift-nio"
                ),
                .product(
                    name: "NIOWebSocket",
                    package: "swift-nio"
                ),
                .product(name: "WebSocketKit", package: "websocket-kit"),
            ]
        ),
    ]
)
