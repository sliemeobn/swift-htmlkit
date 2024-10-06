// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Benchmarks",
    platforms: [
        .macOS(.v14)
    ],
    dependencies: [
        .package(url: "https://github.com/ordo-one/package-benchmark", from: "1.27.0"),
        .package(url: "https://github.com/RandomHashTags/swift-htmlkit", from: "0.4.0"),
        .package(url: "https://github.com/sliemeobn/elementary", from: "0.3.4"),
        .package(url: "https://github.com/vapor-community/HTMLKit", from: "2.8.1"),
        .package(url: "https://github.com/pointfreeco/swift-html", from: "0.4.1"),
        //.package(name: "BBHTML", url: "https://github.com/BinaryBirds/swift-html", from: "1.7.0") // conflicting package name
        .package(url: "https://github.com/JohnSundell/Plot", from: "0.14.0"),
        //.package(url: "https://github.com/toucansites/toucan", from: "1.0.0-alpha.1"), // unstable
        //.package(url: "https://github.com/robb/Swim", from: "0.4.0") // compile problem
        .package(url: "https://github.com/dokun1/Vaux", from: "0.2.0") // result limitation
    ],
    targets: [
        .target(
            name: "Utilities",
            path: "Benchmarks/Utilities"
        ),
        .target(
            name: "TestElementary",
            dependencies: [
                "Utilities",
                .product(name: "Elementary", package: "Elementary"),
            ],
            path: "Benchmarks/Elementary"
        ),
        .target(
            name: "TestPlot",
            dependencies: [
                "Utilities",
                .product(name: "Plot", package: "Plot")
            ],
            path: "Benchmarks/Plot"
        ),
        .target(
            name: "TestSwiftHTMLBB",
            dependencies: [
                "Utilities",
                //.product(name: "SwiftHtml", package: "BBHTML")
            ],
            path: "Benchmarks/SwiftHTMLBB"
        ),
        .target(
            name: "TestSwiftHTMLKit",
            dependencies: [
                "Utilities",
                .product(name: "HTMLKit", package: "swift-htmlkit", moduleAliases: ["HTMLKit" : "SwiftHTMLKit"]),
                .product(name: "HTMLKit", package: "HTMLKit", moduleAliases: ["HTMLKit" : "VaporHTMLKit"])
            ],
            path: "Benchmarks/SwiftHTMLKit"
        ),
        .target(
            name: "TestSwiftHTMLPF",
            dependencies: [
                "Utilities",
                .product(name: "Html", package: "swift-html"),
            ],
            path: "Benchmarks/SwiftHTMLPF"
        ),
        .target(
            name: "TestSwim",
            dependencies: [
                "Utilities",
                /*.product(name: "Swim", package: "Swim"),
                .product(name: "HTML", package: "Swim")*/
            ],
            path: "Benchmarks/Swim"
        ),
        .target(
            name: "TestToucan",
            dependencies: [
                "Utilities"
            ],
            path: "Benchmarks/Toucan"
        ),
        .target(
            name: "TestVaporHTMLKit",
            dependencies: [
                "Utilities",
                .product(name: "HTMLKit", package: "swift-htmlkit", moduleAliases: ["HTMLKit" : "SwiftHTMLKit"]),
                .product(name: "HTMLKit", package: "HTMLKit", moduleAliases: ["HTMLKit" : "VaporHTMLKit"])
            ],
            path: "Benchmarks/VaporHTMLKit"
        ),
        .target(
            name: "TestVaux",
            dependencies: [
                "Utilities",
                .product(name: "Vaux", package: "Vaux")
            ],
            path: "Benchmarks/Vaux"
        ),

        .executableTarget(
            name: "Benchmarks",
            dependencies: [
                "Utilities",
                "TestElementary",
                "TestPlot",
                "TestSwiftHTMLBB",
                "TestSwiftHTMLKit",
                "TestSwiftHTMLPF",
                "TestSwim",
                "TestToucan",
                "TestVaporHTMLKit",
                "TestVaux",
                .product(name: "Benchmark", package: "package-benchmark")
            ],
            path: "Benchmarks/Benchmarks",
            plugins: [
                .plugin(name: "BenchmarkPlugin", package: "package-benchmark")
            ]
        )
    ]
)
