//
//  TortoiseState.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/14.
//

import Foundation
import CoreGraphics

struct TortoiseState {

    var position: CGPoint = .zero

    var heading: Degree = Degree(0)

    var pen: Pen = Pen()

    var shape: Shape = .tortoise

    var fillPath: [CGPoint]?

    // TODO: SPEED
}
