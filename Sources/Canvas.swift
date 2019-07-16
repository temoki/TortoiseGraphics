//
//  Canvas.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import Foundation

public protocol Canvas {

    var size: CGSize { get }

    var scale: CGFloat { get }

    var backgroundColor: Color { get set }

    func drawing(_ block: @escaping (Tortoise) -> Void)

}
