//
//  CGContext+.swift
//  TortoiseGraphics
//
//  Created by temoki on 2017/05/02.
//
//

import CoreGraphics

extension CGContext {

    func tg_helloTortoiseGraphicsWorld() {
        tg_convertCoordinateSystem()
        tg_moveOriginToCenter()
    }

    func tg_convertCoordinateSystem() {
        #if os(iOS)
            // https://developer.apple.com/library/content/documentation/General/Conceptual/Devpedia-CocoaApp/CoordinateSystem.html
            // The default coordinate system for views in iOS and OS X
            // differ in the orientation of the vertical axis:
            translateBy(x: 0, y: CGFloat(height))
            scaleBy(x: 1, y: -1)
        #endif
    }

    func tg_moveOriginToCenter() {
        translateBy(x: CGFloat(width) * 0.5, y: CGFloat(height) * 0.5)
    }

}
