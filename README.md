# CodeSyntaxCSSGenerator

A [Publish](https://github.com/johnsundell/publish) plugin that generates a syntax code css styles for you [Splash Plugin](https://github.com/johnsundell/splashpublishplugin) from Xcode Color Theme.

## Install

To install it into your [Publish](https://github.com/johnsundell/publish) package, add it as a dependency within your `Package.swift` manifest:
```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(url: "https://github.com/SpectralDragon/CodeSyntaxCSSGenerator.git", from: "0.1.0")
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "CodeSyntaxCSSGenerator"
            ]
        )
    ]
    ...
)
```

## Usage

Move `dvtcolortheme` or `xccolortheme` file to Resource dirictory and intall the plugin in any place in build step.

```swift

// My xcode theme `Light.dvtcolortheme`

import CodeSyntaxCSSGenerator

Site().publish(using: [
    .installPlugin(
        .generateCodeCSS(withClassPrefix: "pre code .s-",
                         theme: .xcode("Light.dvtcolortheme"))
    ),
])
```

after that, the plugin will generate `codesyntax.css` file

```css 
pre code .s-preprocessing {
    color: #63381FFF
}

pre code .s-comment {
    color: #007400FF
}

pre code .s-number {
    color: #1C00CEFF
}

pre code .s-call {
    color: #25464AFF
}

pre code .s-property {
    color: #3E6D74FF
}

pre code .s-keyword {
    color: #A90D91FF
}

pre code .s-dotAccess {
    color: #25464AFF
}

pre code .s-type {
    color: #3E6D74FF
}

pre code .s-string {
    color: #C41A15FF
}
```

Also plugin can generate css to dark scheme, just use `CodeTheme.dynamic(light: CodeTheme, dark: CodeTheme)` case. The plugin add `@media(prefers-color-scheme: dark)` with passed code theme.


# Features

[ ] intellij theme
[ ] VSCode

Thank you and enjoy 💯
