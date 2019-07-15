//
//  Tortoise.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/15.
//

import Foundation
import CoreGraphics

public class Tortoise {

    public let name: String

    public init(name: String, canvas: ImageCanvas) {
        self.name = name
        self.canvas = canvas
    }

    public func forward(_ distance: CGFloat) {
        let transform = CGAffineTransform(translationX: state.position.x, y: state.position.y)
            .rotated(by: -state.heading.radian.value)
        let newPosition = CGPoint(x: 0, y: distance).applying(transform)

        if state.isPenDown {
            let path = CGMutablePath()
            path.move(to: state.position)
            path.addLine(to: newPosition)
            canvas.strokePath(path: path, color: state.penColor, lineWidth: state.penSize)
        }

        state.position = newPosition
    }

    // MARK: - Internal

    var state: TortoiseState = TortoiseState()

    let canvas: ImageCanvas

}
