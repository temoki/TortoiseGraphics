//
//  CommandPrint.swift
// TortoiseGraphics
//
//  Created by temoki on 2016/08/23.
//  Copyright © 2016 temoki. All rights reserved.
//

import CoreGraphics

class CommandPrint: Command {

    let number: NumberOutput?
    let boolean: BoolOutput?

    init(number: @escaping NumberOutput) {
        self.number = number
        self.boolean = nil
    }

    init(boolean: @escaping BoolOutput) {
        self.number = nil
        self.boolean = boolean
    }

    func execute(context: Context) {
        let header = "🐢> "
        if let number = number?(Properties(context: context)) {
            print("\(header) \(number)")
        } else if let boolean = boolean?(Properties(context: context)) {
            print("\(header) \(boolean)")
        }
    }

}
