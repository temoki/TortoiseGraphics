//
//  Tortoise+Alias.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/22.
//

import Foundation

extension Tortoise {

    /// Alias to `forward()`
    public func fd(_ distance: Double) {
        forward(distance)
    }

    /// Alias to `backward()`
    public func back(_ distance: Double) {
        backword(distance)
    }

    /// Alias to `backward()`
    public func bk(_ distance: Double) {
        backword(distance)
    }

    /// Alias to `right()`
    public func rt(_ angle: Double) {
        right(angle)
    }

    /// Alias to `left()`
    public func lt(_ angle: Double) {
        left(angle)
    }

    /// Alias to `penDown()`
    public func pd() {
        penDown()
    }

    /// Alias to `penDown()`
    public func down() {
        penDown()
    }

    /// Alias to `penUp()`
    public func pu() {
        penUp()
    }

    /// Alias to `penUp()`
    public func up() {
        penUp()
    }

    /// Alias to `penSize()`
    public func width(_ width: Double) {
        penSize(width)
    }

    /// Alias to `penSize`
    public var width: Double {
        return penSize
    }

    /// Alias to `showTortoise()`
    public func st() {
        showTortoise()
    }

    /// Alias to `hideTortoise()`
    public func ht() {
        hideTortoise()
    }

}
