//
//  CATransaction+.swift
//  TortoiseGraphics
//
//  Created by Tomoki Kobayashi on 2019/07/26.
//

import QuartzCore

extension CATransaction {

    class func transaction(_ block: () -> Void, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        block()
        CATransaction.commit()
    }

    class func transactionWithoutAnimation(_ block: () -> Void, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        CATransaction.setCompletionBlock(completion)
        block()
        CATransaction.commit()
    }

}
