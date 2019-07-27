//
//  Color.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/27.
//

import Foundation

public struct Color: CustomStringConvertible {

    public var r: Double {
        didSet { r = Color.componentToPresentationValue(r) }
    }

    public var g: Double {
        didSet { g = Color.componentToPresentationValue(g) }
    }

    public var b: Double {
        didSet { b = Color.componentToPresentationValue(b) }
    }

    public var name: String?

    public init(_ r: Double, _ g: Double, _ b: Double, name: String? = nil) {
        self.r = Color.componentToRawValue(r)
        self.g = Color.componentToRawValue(g)
        self.b = Color.componentToRawValue(b)
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

    public enum Mode: Double {
        case range0to1 = 1.0
        case range0to255 = 255.0
    }

    public static var mode: Mode = .range0to255

    // MARK: - CustomStringConvertible

    public var description: String {
        if let name = self.name { return name }
        let presenR = Color.componentToPresentationValue(r)
        let presenG = Color.componentToPresentationValue(g)
        let presenB = Color.componentToPresentationValue(b)
        return "(\(presenR),\(presenG),\(presenB))"
    }

    // MARK: - Private

    private static func componentToRawValue(_ component: Double) -> Double {
        return max(0, min(component, mode.rawValue)) / mode.rawValue
    }

    private static func componentToPresentationValue(_ component: Double) -> Double {
        return component * mode.rawValue
    }

}
