import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension CGColor {

    static var clear: CGColor {
        #if os(iOS)
        return UIColor.clear.cgColor
        #elseif os(macOS)
        return NSColor.clear.cgColor
        #endif
    }

}
