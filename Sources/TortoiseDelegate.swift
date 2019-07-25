//
//  TortoiseDelegate.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import Foundation
import CoreGraphics

protocol TortoiseDelegate {

    func initialized(_ state: TortoiseState)

    func positionChanged(_ state: TortoiseState, from position: CGPoint)

    func headingChanged(_ state: TortoiseState, from heading: Angle)

    func penChanged(_ state: TortoiseState, from pen: Pen)

    func shapeChanged(_ state: TortoiseState, from shape: Shape)

    func fillRequested(_ state: TortoiseState)

}
