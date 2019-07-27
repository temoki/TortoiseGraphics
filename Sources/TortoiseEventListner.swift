//
//  TortoiseEventListner.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/16.
//

import Foundation
import CoreGraphics

protocol TortoiseEventListner {

    func initialized(_ state: TortoiseState)

    func positionChanged(_ state: TortoiseState)

    func headingChanged(_ state: TortoiseState)

    func penChanged(_ state: TortoiseState)

    func shapeChanged(_ state: TortoiseState)

    func fillRequested(_ state: TortoiseState)

}
