//
//  RGB+.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/27.
//

import Foundation
import CoreGraphics

extension RGB {

    var cgColor: CGColor {
        return CGColor.fromRGB(self)
    }

}
