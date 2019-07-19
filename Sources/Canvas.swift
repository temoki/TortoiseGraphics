//
//  Canvas.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import Foundation
import CoreGraphics

public protocol Canvas {

    var size: CGSize { get }

    var scale: CGFloat { get }

    var color: Color { get set }

}
