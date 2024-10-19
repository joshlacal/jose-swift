// swift-tools-version: 5.8.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JoseSwift",  // Update the package name to a valid Swift identifier
    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .macCatalyst(.v14),
        .tvOS(.v14),
        .watchOS(.v5)
    ],
    products: [
        .library(
            name: "JoseSwift",  // Change to a valid product name without the hyphen
            targets: [
                "JSONWebKey",
                "JSONWebAlgorithms",
                "JSONWebEncryption",
                "JSONWebSignature",
                "JSONWebToken"
            ]
        ),
        .library(
            name: "JoseSwiftDocs",  // Change the docs library name to a valid identifier
            targets: [
                "JoseSwift"  // Refer to the renamed library in the docs target
            ]
        )
    ],
    dependencies: [
        // For `secp256k1` support
        .package(url: "https://github.com/GigaBitcoin/secp256k1.swift.git", .upToNextMinor(from: "0.15.0")),
        // For `AES_CBC_HMAC_SHA2`, `PBES2` and RSA DER encoding support
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMinor(from: "1.8.1"))
    ],
    targets: [
        .target(
            name: "JSONWebAlgorithms",
            dependencies: [
                "JSONWebKey",
                .product(name: "secp256k1", package: "secp256k1.swift"),
                .product(name: "CryptoSwift", package: "CryptoSwift")
            ]
        ),
        .testTarget(
            name: "JWATests",
            dependencies: ["JSONWebAlgorithms", "Tools"]
        ),
        .target(
            name: "JSONWebSignature",
            dependencies: [
                "JSONWebKey",
                "JSONWebAlgorithms"
            ]
        ),
        .testTarget(
            name: "JWSTests",
            dependencies: ["JSONWebSignature", "Tools"]
        ),
        .target(
            name: "JSONWebEncryption",
            dependencies: [
                "JSONWebAlgorithms",
                "JSONWebKey",
                "CryptoSwift"
            ]
        ),
        .testTarget(
            name: "JWETests",
            dependencies: ["JSONWebEncryption", "Tools"]
        ),
        .target(
            name: "JSONWebKey",
            dependencies: [
                "CryptoSwift",
                "Tools",
                .product(name: "secp256k1", package: "secp256k1.swift")
            ]
        ),
        .testTarget(
            name: "JWKTests",
            dependencies: ["JSONWebKey", "Tools"]
        ),
        .target(
            name: "JSONWebToken",
            dependencies: [
                "JSONWebKey",
                "JSONWebSignature",
                "JSONWebEncryption",
                "Tools"
            ]
        ),
        .testTarget(
            name: "JWTTests",
            dependencies: ["JSONWebToken", "Tools"]
        ),
        .target(
            name: "Tools"
        ),
        // This target exists just to build documentation, should not be used for development
        .target(
            name: "JoseSwift",  // Change to a valid target name without the hyphen
            dependencies: [
                "JSONWebKey",
                "JSONWebSignature",
                "JSONWebAlgorithms",
                "JSONWebEncryption",
                "JSONWebToken"
            ]
        )
    ]
)
