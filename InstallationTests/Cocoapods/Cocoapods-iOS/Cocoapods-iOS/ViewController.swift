//
//  ViewController.swift
//  Cocoapods-iOS
//
//  Created by temoki on 2017/05/01.
//  Copyright © 2017年 temoki. All rights reserved.
//

import UIKit
import TortoiseGraphics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = CanvasView(canvasSize: self.view.bounds.size, tortoise: #imageLiteral(resourceName: "Tortoise"))
        self.view.addSubview(view)
        view.canvas.🐢
            .repeat(36) { $0
                .repeat(3) { $0
                    .forward(100)
                    .right(120)
                }
                .right(10)
        }
        view.animate(atTimeInterval: 0.1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

