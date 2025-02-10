// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "NumbersData",
    platforms: [
        .iOS(.v14), .macOS(.v12),
    ],
    products: [
        .library(
            name: "NumbersData",
            targets: ["NumbersData"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/SimplyDanny/SwiftLintPlugins",
            from: "0.2.2")
    ],
    targets: [
        .target(
            name: "NumbersData",
            plugins: [
                .plugin(
                    name: "SwiftLintBuildToolPlugin",
                    package: "SwiftLintPlugins")
            ]
        ),
        .testTarget(
            name: "NumbersDataTests",
            dependencies: ["NumbersData"]
        ),
    ]
)
