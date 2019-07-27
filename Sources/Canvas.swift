//
//  Canvas.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import Foundation
import CoreGraphics

public protocol Canvas {

    var canvasSize: CGSize { get }

    var canvasColor: Color { get set }

}
