//
// Created by Sergey Suslov on 20.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit

class Cron {
    static let sharedInstance = Cron()
    private var crons: [CronItemBase] = [CronItemUploadNotDeliveredPost(), CronItemUpdatePosts()]

    func run() {
        DispatchQueue.main.async { [weak self] in
            guard let c = self?.crons else {
                return
            }
            c.forEach {
                $0.run()
            }
        }
    }

    func stop() {
        DispatchQueue.main.async { [weak self] in
            guard let c = self?.crons else {
                return
            }
            c.forEach {
                $0.stop()
            }
        }
    }

    class func run() {
        sharedInstance.run()
    }

    class func stop() {
        sharedInstance.stop()
    }

    deinit {
        Log.trace("DEINIT_CRON")
    }
}
