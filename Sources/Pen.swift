//
//  Pen.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/24.
//

import CoreGraphics

struct Pen {

    var isDown: Bool = true

    var color: RGB = ColorPalette.black.rgb

    var width: Double = 1

    var fillColor: RGB = ColorPalette.black.rgb

}
