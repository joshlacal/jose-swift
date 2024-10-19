// swift-tools-version: 5.8.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "jose-swift",
    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .macCatalyst(.v14),
        .tvOS(.v14),
        .watchOS(.v5)
    ],
    products: [
        .library(
            name: "JoseSwift",
            targets: [
                "JSONWebKey",
                "JSONWebAlgorithms",
                "JSONWebEncryption",
                "JSONWebSignature",
                "JSONWebToken"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/GigaBitcoin/secp256k1.swift.git", .upToNextMinor(from: "0.15.0")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMinor(from: "1.8.1"))
    ],
    targets: [
        .target(
            name: "JSONWebAlgorithms",
            dependencies: [
                "JSONWebKey",
                .product(name: "secp256k1", package: "secp256k1.swift"),
                .product(name: "CryptoSwift", package: "CryptoSwift")
            ],
            path: "Sources/JSONWebAlgorithms"
        ),
        .testTarget(
            name: "JWATests",
            dependencies: ["JSONWebAlgorithms", "Tools"],
            path: "Tests/JWATests"
        ),
        .target(
            name: "JSONWebSignature",
            dependencies: [
                "JSONWebKey",
                "JSONWebAlgorithms"
            ],
            path: "Sources/JSONWebSignature"
        ),
        .testTarget(
            name: "JWSTests",
            dependencies: ["JSONWebSignature", "Tools"],
            path: "Tests/JWSTests"
        ),
        .target(
            name: "JSONWebEncryption",
            dependencies: [
                "JSONWebAlgorithms",
                "JSONWebKey",
                "CryptoSwift"
            ],
            path: "Sources/JSONWebEncryption"
        ),
        .testTarget(
            name: "JWETests",
            dependencies: ["JSONWebEncryption", "Tools"],
            path: "Tests/JWETests"
        ),
        .target(
            name: "JSONWebKey",
            dependencies: [
                "CryptoSwift",
                "Tools",
                .product(name: "secp256k1", package: "secp256k1.swift")
            ],
            path: "Sources/JSONWebKey"
        ),
        .testTarget(
            name: "JWKTests",
            dependencies: ["JSONWebKey", "Tools"],
            path: "Tests/JWKTests"
        ),
        .target(
            name: "JSONWebToken",
            dependencies: [
                "JSONWebKey",
                "JSONWebSignature",
                "JSONWebEncryption",
                "Tools"
            ],
            path: "Sources/JSONWebToken"
        ),
        .testTarget(
            name: "JWTTests",
            dependencies: ["JSONWebToken", "Tools"],
            path: "Tests/JWTTests"
        ),
        .target(
            name: "Tools",
            path: "Sources/Tools"
        )
    ]
)
