//
// Created by Sergey Suslov on 20.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyTimer


class CronItemBase {
    internal var timer: Timer?
    internal var interval: TimeInterval = 60.second
    internal var block: (() -> Void)!

    func run() {
        guard  let block = block else {
            return
        }
        self.stop()

        timer = Timer.new(every: interval, block)
        timer?.start()
        block()
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        self.stop()
    }
}
