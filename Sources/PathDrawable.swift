//
//  PathDrawable.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import Foundation
import CoreGraphics

protocol PathDrawable {

    func strokePath(path: [CGPoint], color: CGColor, lineWidth: CGFloat)

    func fillPath(path: [CGPoint], color: CGColor)

}
