//
//  ViewController.swift
//  Cocoapods-macOS
//
//  Created by temoki on 2017/05/01.
//  Copyright © 2017年 temoki. All rights reserved.
//

import Cocoa
import TortoiseGraphics

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = CanvasView(canvasSize: self.view.bounds.size)
        self.view.addSubview(view)
        view.canvas.🐢
            .repeat(36) { $0
                .repeat(3) { $0
                    .forward(100)
                    .right(120)
                }
                .right(10)
        }
        view.animate(atTimeInterval: 0.1)    }

    override var representedObject: Any? {
        didSet {
        }
    }


}

