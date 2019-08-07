import Foundation

public enum Speed: String {
    case fastest
    case fast
    case normal
    case slow
    case slowest
}

extension Speed: Codable {
}
