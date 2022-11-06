// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Armchair",
    defaultLocalization: "en",
    products: [
        .library(
            name: "Armchair",
            targets: ["Armchair"]),
    ],
    targets: [
        .target(
            name: "Armchair",
            path: "Source",
            exclude: ["Info-Localizable.plist", "Info.plist"],
            resources: [
                .process("Localization")
            ]
        ),
        .testTarget(
            name: "ArmchairTests",
            dependencies: ["Armchair"],
            path: "Tests"
        )
    ]
)
