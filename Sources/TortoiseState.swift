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

    var isPenDown: Bool = true

    var penSize: CGFloat = 1

    var penColor: CGColor = Color.black.cgColor

    var fillColor: CGColor = Color.black.cgColor

    var isVisible: Bool = true

    var fillPath: CGMutablePath?

    var shape: Shape = .tortoise

}
