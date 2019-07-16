//
//  PathDrawable.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import Foundation
import CoreGraphics

protocol PathDrawable {

    func strokePath(path: CGPath, color: CGColor, lineWidth: CGFloat)

    func fillPath(path: CGPath, color: CGColor)

}
