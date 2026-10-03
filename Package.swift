// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ShowSeats",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(name: "ShowSeats", targets: ["ShowSeats"])
    ],
    targets: [
        .target(name: "ShowSeats"),
        .testTarget(name: "ShowSeatsTests", dependencies: ["ShowSeats"])
    ]
)
