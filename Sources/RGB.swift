//
//  RGB.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/27.
//

import Foundation

public struct RGB: CustomStringConvertible {

    public var r: Double {
        didSet { r = fit(r) }
    }

    public var g: Double {
        didSet { r = fit(g) }
    }

    public var b: Double {
        didSet { r = fit(b) }
    }

    public var name: String?

    public init(_ r: Double, _ g: Double, _ b: Double, name: String? = nil) {
        self.r = fit(r)
        self.g = fit(g)
        self.b = fit(b)
        self.name = name
    }

    public init(_ r: UInt8, _ g: UInt8, _ b: UInt8, name: String? = nil) {
        self.r = fit(r)
        self.g = fit(g)
        self.b = fit(b)
        self.name = name
    }

    public init(_ hex: String, name: String? = nil) {
        let scanner = Scanner(string: hex)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            self.r = Double((color & 0xFF0000) >> 16) / 255.0
            self.g = Double((color & 0x00FF00) >> 8)  / 255.0
            self.b = Double((color & 0x0000FF) >> 0)  / 255.0
            self.name = name ?? hex
        } else {
            self.r = 0
            self.g = 0
            self.b = 0
            self.name = nil
        }
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        return name ?? "(\(r),\(g),\(b))"
    }

}

private func fit(_ component: Double) -> Double {
    return max(0, min(component, 1))
}

private func fit(_ component: UInt8) -> Double {
    return Double(component) / Double(UInt8.max)
}
