//
//  CanvasView.swift
//  Cocoapods-iOS
//
//  Created by temoki on 2017/12/17.
//  Copyright © 2017年 temoki. All rights reserved.
//

import UIKit
import TortoiseGraphics

class CanvasView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let canvas = GraphicsCanvas(size: bounds.size, context: context)
        canvas.drawing { 🐢 in
            🐢.penColor(.red)
            🐢.fillColor(.yellow)
            
            🐢.penUp()
            🐢.back(100)
            🐢.penDown()
            
            // Turtle Star!
            🐢.beginFill()
            🐢.repeat(36) {
                🐢.forward(200)
                🐢.left(170)
            }
            🐢.endFill()
        }
    }

}
