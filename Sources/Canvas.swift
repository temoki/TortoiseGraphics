//
//  Canvas.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import Foundation

public protocol Canvas {

    var canvasSize: Vec2D { get }

    var canvasColor: Color { get set }

}
