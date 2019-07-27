//
//  Canvas.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import Foundation

public protocol Canvas {

    var canvasSize: Vec2D { get }

    func canvasColor(_ color: Color)

    func canvasColor(_ r: Double, _ g: Double, _ b: Double)

    func canvasColor(_ rgb: RGB)

    var canvasColor: RGB { get }

}
