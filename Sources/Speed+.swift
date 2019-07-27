//
//  Speed+.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/27.
//

import Foundation
import CoreGraphics

extension Speed {

    func movementDuration(distance: CGFloat) -> CFTimeInterval {
        return CFTimeInterval(Double(distance) / (velocity * 100.0))
    }

    func animationDuration() -> CFTimeInterval {
        return CFTimeInterval(1.0 / velocity)
    }

    private var velocity: Double {
        switch self {
        case .fastest: return 10
        case .fast: return 8
        case .normal: return 6
        case .slow: return 4
        case .slowest: return 2
        }
    }

}