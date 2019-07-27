//
//  TortoiseState.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/14.
//

import Foundation
import CoreGraphics

struct TortoiseState {

    var position: Vec2D = Vec2D()

    var heading: Angle = Degree(0)

    var pen: Pen = Pen()

    var shape: Shape = .tortoise

    var speed: Speed = .normal

    var fillPath: [Vec2D]?

}
