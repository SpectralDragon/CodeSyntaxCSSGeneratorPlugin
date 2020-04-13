import Foundation
import Files
import PublishColorUtils
import Splash
import Publish

// An object that has information about theme.
public enum CodeTheme {
    // Path to `xccolortheme` or `dvtcolortheme`
    case xcode(_ path: Path)
    
    // Your custom theme
    case custom(builder: (TokenType) -> PublishColorUtils.Color)
    
    // Code theme for dark and light theme
    indirect case dynamic(light: CodeTheme, dark: CodeTheme)
    
    internal enum Colors {
        case single([TokenType: PublishColorUtils.Color])
        case dynamic([TokenType: PublishColorUtils.Color], [TokenType: PublishColorUtils.Color])
        
        internal var single: [TokenType: PublishColorUtils.Color] {
            guard case .single(let value) = self else { return [:] }
            return value
        }
    }
}

extension CodeTheme {
    func colors(resourceFolder root: Folder) throws -> Colors {
        switch self {
        case .xcode(let path):
            let file = try root.file(at: path.string)
            let data = try file.read()
            var format = PropertyListSerialization.PropertyListFormat.xml
            let scheme = try PropertyListSerialization.propertyList(from: data, options: [], format: &format) as! [String: Any]
            
            let colors = Self.colorsFromXcodeScheme(scheme)
            return .single(colors)
        case .custom(let builder):
            
            var colors = [TokenType: PublishColorUtils.Color]()
            
            for token in TokenType.allCases {
                colors[token] = builder(token)
            }
            
            return .single(colors)
        case .dynamic(let light, let dark):
            return try .dynamic(light.colors(resourceFolder: root).single, dark.colors(resourceFolder: root).single)
        }
    }
}

extension TokenType {
    static var allCases: [TokenType] = [.call, .comment, .dotAccess, .keyword, .number, .preprocessing, .property, .string, .type]
}
