import Foundation
import PublishColorUtils
import Splash

extension CodeTheme {
    static func colorsFromXcodeScheme(_ scheme: [String: Any]) -> [TokenType: PublishColorUtils.Color] {
        let syntaxColors = scheme["DVTSourceTextSyntaxColors"] as! [String: String]
        
        var colors = [TokenType: PublishColorUtils.Color]()
        
        for token in TokenType.allCases {
            let strings = syntaxColors[token.xcodeSchemeKey]?.split(separator: " ").map { String($0) } ?? []
            guard strings.count == 4 else { continue }
            let red = Float(strings[0])!
            let green = Float(strings[1])!
            let blue = Float(strings[2])!
            let alpha = Float(strings[3])!
            let color = Color(red: red, green: green, blue: blue, alpha: alpha)
            colors[token] = color
        }
        
        return colors
    }
}

fileprivate extension TokenType {
    var xcodeSchemeKey: String {
        switch self {
        case .call, .dotAccess: return "xcode.syntax.identifier.function"
        case .comment: return "xcode.syntax.comment"
        case .keyword: return "xcode.syntax.keyword"
        case .number: return "xcode.syntax.number"
        case .preprocessing: return "xcode.syntax.preprocessor"
        case .property: return "xcode.syntax.identifier.variable"
        case .string: return "xcode.syntax.string"
        case .type: return "xcode.syntax.identifier.type"
        case .custom(_): return "xcode.syntax.plain"
        }
    }
}
