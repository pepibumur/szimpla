import Foundation

enum Value: Equatable {
    case StringLiteral(String)
    case RegularExpression(NSRegularExpression)
}

