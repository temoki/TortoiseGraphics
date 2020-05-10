//
//  CanvasView.swift
//  Cocoapods-iOS
//
//  Created by temoki on 2017/12/17.
//  Copyright © 2017 temoki. All rights reserved.
//

import UIKit
import TortoiseGraphics

class CanvasView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let canvas = ImageCanvas(size: Vec2D(Double(bounds.size.width),
                                             Double(bounds.size.height)),
                                 scale: Double(UIScreen.main.scale))
        let 🐢 = Tortoise()
        canvas.add(🐢)

        🐢.penColor(.red)
        🐢.fillColor(.yellow)
        
        🐢.penUp()
        🐢.back(100)
        🐢.penDown()
        
        // Turtle Star!
        🐢.beginFill()
        36.timesRepeat {
            🐢.forward(200)
            🐢.left(170)
        }
        🐢.endFill()
        
        if let image = canvas.cgImage {
            context.draw(image, in: bounds)
        }
    }

}
